import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class PaymentTile extends StatelessWidget {
  var amount;

  PaymentTile(
      {required this.isPaid,
      required this.treatmentTitle,
      required this.doctorName,
      required this.treatmentDate,
      required this.amount,
      required this.paymentIntent});
  bool isPaid;
  String treatmentTitle;
  String doctorName;
  String paymentIntent;
  Color status = Colors.grey;
  Color statusPaid = Colors.greenAccent;
  Color statusUnpaid = Colors.redAccent;
  final DateTime treatmentDate;
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd.MM.yyyy HH:mm').format(treatmentDate);
    return ListTile(
      leading: Text(treatmentTitle),
      title: Text(formattedDate),
      subtitle: Text('Payment ID: $paymentIntent'),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$amount \$'),
              Icon(
                Icons.payment,
                color: isPaid ? statusPaid : statusUnpaid,
              ),
            ],
          )
        ],
      ),
    );
  }
}
