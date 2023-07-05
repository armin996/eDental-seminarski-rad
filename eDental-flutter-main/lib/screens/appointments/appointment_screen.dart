import 'dart:async';

import 'package:edental/models/dentist.dart';
import 'package:edental/providers/appointmentProvider.dart';
import 'package:edental/screens/appointments/dentist_recommendation.dart';
import 'package:edental/screens/settings/widgets/appointment_timeCounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/appointment.dart';
import '../../providers/auth.dart';
import '../../providers/dentist.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  Dentist? selectedDentist = null;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future pickDateRange(
      DateTimeRange? initialDateRange, DateTime firstDate) async {
    DateTimeRange? dateRange = await showDateRangePicker(
        context: context,
        initialDateRange: initialDateRange,
        firstDate: firstDate,
        cancelText: 'Close',
        lastDate: DateTime(DateTime.now().year, 12, 31));
    if (dateRange != null && dateRange.duration.inDays != 6) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 5),
          content: Text('Range has to be a week')));
      return;
    }
    if (dateRange?.start.weekday != 1 && dateRange?.end.weekday != 7) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 5),
          content: Text('Please choose dates between monday and sunday')));
      return;
    }

    return dateRange;
  }

  bool isDentistChanged = false;
  int? previousDentistId = null;

  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<AppointmentProvider>(context);
    final dentists = Provider.of<DentistProvider>(context);
    final dentistList = dentists.getDentists();
    final deviceSize = MediaQuery.of(context).size;
    final authProvider = Provider.of<Auth>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Appointments',
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppointmentTimeCounter(),
              Consumer<AppointmentProvider>(
                builder: (context, appointments, child) => Container(
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DropdownButtonHideUnderline(
                            child: FutureBuilder<List<Dentist>>(
                              future: dentists.getDentistsAsync(),
                              builder: (context, snapshot) {
                                return DropdownButton(
                                    itemHeight: null,
                                    value: selectedDentist,
                                    borderRadius: BorderRadius.circular(5.0),
                                    hint: const Text(
                                      'Choose doctor',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: dentists.getDentistsDropdown(),
                                    onChanged: (val) async {
                                      setState(() {
                                        selectedDentist = val;
                                      });
                                      await appointments
                                          .setDentistAppointments(val.id);
                                    });
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => pickDateRange(
                                    appointments.weekRange,
                                    DateTime.now().add(Duration(
                                        days: -(DateTime.now().weekday - 1))))
                                .then((value) {
                              if (value != null) {
                                appointments.setWeekDaysFromRange(value);
                              }
                            }),
                            child: Text(
                                '${DateFormat('dd.MM.yyyy').format(appointments.firstDayOfWeek)}-${DateFormat('dd.MM.yyyy').format(appointments.lastDayOfWeek)}'),
                          )
                        ]),
                    SizedBox(
                        height: deviceSize.height / 8,
                        width: deviceSize.width,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: weekDays.map((e) => Text(e)).toList())),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:
                            appointments.appointmentItems.entries.map((e) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: e.value);
                        }).toList()),
                    FutureBuilder(
                      future: dentists.getRecommendedDentistAsync(
                          id: selectedDentist?.id ?? 1),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Recommendations(
                              snapshot.data ?? [], "Recommended dentists");
                        }
                        if (snapshot.hasError) {
                          return const Text('Error has occurred');
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    FutureBuilder(
                      future: dentists.getOtherDentistAsync(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Recommendations(
                              snapshot.data ?? [], 'Other dentists');
                        }
                        if (snapshot.hasError) {
                          return const Text('Error has occurred');
                        }
                        return const CircularProgressIndicator();
                      },
                    )
                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}
