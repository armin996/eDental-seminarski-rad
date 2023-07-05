import 'dart:math';

import 'package:edental/components/payment_tile.dart';
import 'package:flutter/material.dart';

import '../models/payment.dart';

class TotalTile extends StatefulWidget {
  TotalTile(this.paidReceipts, {super.key});
  List<Payment> paidReceipts = [];
  List<PaymentTile> unpaidReceipts = [];
  List<PaymentTile> totalReceipts = [];

  @override
  State<TotalTile> createState() => _TotalTileState();
}

class _TotalTileState extends State<TotalTile> {
  @override
  Widget build(BuildContext context) {
    final totalAmount = widget.paidReceipts.isNotEmpty
        ? widget.paidReceipts
            .map((x) => x.amount)
            .reduce((value, element) => value + element)
        : 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            const Text('Paid Receipts'),
            const SizedBox(height: 8),
            Text('$totalAmount \$')
          ],
        ),
      ],
    );
  }
}
