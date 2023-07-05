import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../helpers/dateJsonFormatter.dart';

@jsonSerializable
class PaymentDto {
  int id;
  @JsonProperty(converter: CustomDateTimeConverter())
  DateTime date;
  double amount;
  int userId;
  int treatmentId;
  String cardNumber;
  String client;
  String treatmentName;
  String? paymentIntent;

  PaymentDto(this.id, this.date, this.amount, this.userId, this.treatmentId,
      this.cardNumber, this.client, this.treatmentName, this.paymentIntent);
}
