import 'package:edental/providers/paymentService.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:edental/components/payment_tile.dart';
import 'package:flutter/material.dart';
import 'package:edental/components/total_tile.dart';
import 'package:provider/provider.dart';

import '../../models/payment.dart';

class TreatmentScreen extends StatefulWidget {
  const TreatmentScreen({super.key});

  @override
  State<TreatmentScreen> createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {
  @override
  Widget build(BuildContext context) {
    final payments = Provider.of<PaymentService>(context);
    final deviceSize = MediaQuery.of(context).size;
    var paymentsForUser = payments.getPaymentsForUser();
    return Scaffold(
      appBar: AppBar(title: const Text('User history')),
      body:

          // Column(children: [
          //   ListView.builder(
          //     itemBuilder: (context, index) => PaymentTile(
          //         isPaid: true,
          //         treatmentTitle: payments[index].treatmentName ?? '',
          //         doctorName: payments[index].cardNumber ?? ''),
          //     itemCount: payments.length,
          //   ),
          //   const SizedBox(
          //     height: 50,
          //   ),
          //   TotalTile(),
          // ])

          FutureBuilder<List<Payment>>(
              future: paymentsForUser,
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: deviceSize.height,
                    width: deviceSize.width,
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(),
                        child: SingleChildScrollView(
                          child: Column(children:
                              // children: [
                              //   ListView.builder(
                              //     itemBuilder: (context, index) =>
                              //         PaymentTile(
                              //             isPaid: true,
                              //             treatmentTitle: snapshot
                              //                     .data![index]
                              //                     .treatmentName ??
                              //                 '',
                              //             doctorName:
                              //                 snapshot.data![index].client ??
                              //                     '',
                              //             treatmentDate:
                              //                 snapshot.data![index].date,
                              //             amount:
                              //                 snapshot.data![index].amount),
                              //     itemCount: snapshot.data!.length,
                              //     scrollDirection: Axis.vertical,
                              //     shrinkWrap: true,
                              //   ),
                              // ],
                              [
                            ...snapshot.data!
                                .map((e) => PaymentTile(
                                      isPaid: true,
                                      treatmentTitle: e.treatmentName ?? '',
                                      doctorName: e.client ?? '',
                                      treatmentDate: e.date,
                                      amount: e.amount,
                                      paymentIntent: e.paymentIntent ?? '',
                                    ))
                                .toList(),
                            TotalTile(snapshot.data!),
                          ]),
                        )),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Can\'t load payments'));
                }
                return const Center(
                  child: Text('No payments'),
                );
              }),
    );
  }
}
