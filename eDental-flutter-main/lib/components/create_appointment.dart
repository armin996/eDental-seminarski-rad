import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CreateAppointment extends StatefulWidget {
  const CreateAppointment({super.key});

  @override
  State<CreateAppointment> createState() => _CreateAppointmentState();
}

class _CreateAppointmentState extends State<CreateAppointment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(label: Text('Start date')),
          )
        ],
      )),
    );
  }
}
