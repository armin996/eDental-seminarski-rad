import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../../models/appointment.dart';
import '../../../providers/appointmentProvider.dart';
import '../../../providers/auth.dart';

class AppointmentTimeCounter extends StatefulWidget {
  const AppointmentTimeCounter({super.key});

  @override
  State<AppointmentTimeCounter> createState() => _AppointmentTimeCounterState();
}

class _AppointmentTimeCounterState extends State<AppointmentTimeCounter> {
  num hours = 0;
  num minutes = 0;
  num seconds = 0;
  Timer? countdownTimer;
  bool isTimerInitialized = false;
  late Future myTask =
      Provider.of<AppointmentProvider>(context).findUpcomingAppointment();
  void showTimer(Appointment? appointment) {
    Duration updateInterval = const Duration(seconds: 1);
    countdownTimer = Timer.periodic(updateInterval, (timer) {
      DateTime now = DateTime.now();
      Duration difference = appointment!.start.difference(now);
      // Update the UI with the remaining time
      setState(() {
        isTimerInitialized = true;
        hours = difference.inHours;
        minutes = difference.inMinutes.remainder(60);
        seconds = difference.inSeconds.remainder(60);
      });
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context);
    final appointments = Provider.of<AppointmentProvider>(context);

    return FutureBuilder(
      future: myTask,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (authProvider.user!.isNotificationEnabled &&
              appointments.upcomingAppointment != null) {
            if (!isTimerInitialized) {
              showTimer(snapshot.data);
            }
            return Text(
              'Upcoming appointment: $hours:$minutes:$seconds',
              style: const TextStyle(color: Colors.red),
            );
          }
          if (authProvider.user!.isNotificationEnabled &&
              appointments.upcomingAppointment == null) {
            return const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text('No upcoming appointments'),
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
