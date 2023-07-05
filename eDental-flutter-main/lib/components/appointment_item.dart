// import 'dart:js_interop';
import 'package:edental/components/appointment_detail.dart';
import 'package:edental/models/appointment.dart';
import 'package:edental/providers/appointmentProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AppointmentItem extends StatefulWidget {
  const AppointmentItem(
      {super.key, this.appointment, required this.appointmentHour});
  final DateTime appointmentHour;
  final Appointment? appointment;
  // ignore: non_constant_identifier_names
  bool get IsReserved =>
      appointment != null &&
      appointment?.start != null &&
      appointment?.end != null &&
      // (
      // (appointment!.start.isBefore(appointmentHour) ||
      appointment!.start.isAtSameMomentAs(appointmentHour)
      // )
      /* &&
          (appointment!.end.isAfter(appointmentHour) ||
              appointment!.end.isAtSameMomentAs(appointmentHour)))*/
      ;
  @override
  State<AppointmentItem> createState() => _AppointmentItemState();
}

class _AppointmentItemState extends State<AppointmentItem> {
  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    final authProvider = Provider.of<Auth>(context);
    int? selectedDentistId = appointmentProvider.selectedDentistId;

    return SizedBox(
      height: 30,
      width: 55,
      child: TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.all(0))),
        onPressed: () async {
          if (selectedDentistId == null) {
            DateTime endDate =
                widget.appointmentHour.add(const Duration(hours: 1));
            final reservations =
                await appointmentProvider.getExistingAppointment(
                    0,
                    widget.appointmentHour,
                    endDate,
                    authProvider.user!.id ?? 0);
            if (reservations != null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("You have already appointment at this time")));
              return;
            }
          }
          showDialog(
            context: context,
            builder: (context) => FractionallySizedBox(
                heightFactor: 0.7,
                widthFactor: 1,
                child: AppointmentDetail(widget, selectedDentistId)),
          );
        },
        child: Text(
            style: TextStyle(
                color: Colors.white,
                backgroundColor:
                    widget.IsReserved ? Colors.red : Colors.green[600]),
            DateFormat('HH:mm').format(widget.appointmentHour)),
      ),
    );
  }
}
