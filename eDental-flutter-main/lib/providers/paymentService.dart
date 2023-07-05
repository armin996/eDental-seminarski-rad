import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:tuple/tuple.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental/apimodels/paymentSearchRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../models/payment.dart';
import '../models/user.dart';
import 'baseProvider.dart';
import 'package:http/http.dart' as http;

class PaymentService extends BaseProvider<Payment, PaymentSearchRequestDto> {
  int userId;
  List<Payment> _payments = [];
  List<Payment> get payments => [..._payments];
  PaymentService(
      {apiName = 'payments',
      required this.userId,
      username = '',
      password = ''})
      : super(apiName, username, password);

  Future<List<Payment>> getPaymentsForUser() async {
    if (payments.isEmpty) {
      PaymentSearchRequestDto sRequest =
          PaymentSearchRequestDto(null, userId, cardNumber: '4242424242424242');
      final result = await super.find(sRequest, path: '/filtering');
      _payments = result;
      notifyListeners();
    }
    return payments;
  }

  Future<String> payTreatment(
      User user, int treatmentId, double price, String treatmentName) async {
    final paymentIntentResult = await createPaymentMethod(
        user.fullName, user.email, user.phone ?? '', price);
    if (paymentIntentResult != 'Failure' ||
        paymentIntentResult != 'Stripe Cancelled') {
      Payment paymentCreateRequest = Payment(
          DateTime.now(), price, userId, treatmentId, '4242424242424242',
          treatmentName: treatmentName,
          client: user.fullName,
          paymentIntent: paymentIntentResult,
          id: 0,
          dentistName: user.fullName);
      final result = await create(paymentCreateRequest);
    }
    return paymentIntentResult;
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      double treatmentPrice) async {
    Map<String, dynamic> body = {
      'amount': ((treatmentPrice * 100).toInt().round()).toString(),
      'currency': 'USD',
      'payment_method_types[]': 'card'
    };
    String secretKey = dotenv.env['SECRET_KEY'] ?? '';
    var response =
        await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
            headers: {
              'Authorization': 'Bearer $secretKey',
              'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: body);
    return json.decode(response.body);
  }

  Future<String> createPaymentMethod(String clientName, String email,
      String phone, double treatmentPrice) async {
    final paymentIntent = await createPaymentIntent(treatmentPrice);
    final BillingDetails billingDetails =
        BillingDetails(name: clientName, phone: phone, email: email);
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      billingDetails: billingDetails,
      paymentIntentClientSecret: paymentIntent!['client_secret'],
      customerId: userId.toString(),
      allowsDelayedPaymentMethods: true,
      googlePay: const PaymentSheetGooglePay(
          testEnv: true, currencyCode: 'BAM', merchantCountryCode: 'BA'),
      merchantDisplayName: clientName,
    ));

    try {
      final result = await Stripe.instance.presentPaymentSheet();
      print(paymentIntent);
      final resultCheck = await Stripe.instance
          .retrievePaymentIntent(paymentIntent['client_secret']);
      return resultCheck.status == PaymentIntentsStatus.Succeeded
          ? resultCheck.id
          : 'Failure';
      return 'Success';
    } catch (e) {
      return 'Stripe Cancelled';
    }
  }

  Future<PaymentIntent?> confirmPayment(String clientName, String cardNumber,
      Map<String, dynamic> paymentIntent, BillingDetails billingDetails) async {
    try {
      // PaymentIntent intent0
      final intentResult = await Stripe.instance.confirmPayment(
          data: PaymentMethodParams.card(
              paymentMethodData:
                  PaymentMethodData(billingDetails: billingDetails)),
          paymentIntentClientSecret: paymentIntent['client_secret']);
      // await Stripe.instance.presentPaymentSheet().then((val) {
      //   Payment payment = Payment(DateTime.now(), intent.amount as double,
      //       userId, treatmentId, 'cardNumber');
      // });
      return intentResult;
    } on Exception catch (e) {
      return null;
    }
  }
}
