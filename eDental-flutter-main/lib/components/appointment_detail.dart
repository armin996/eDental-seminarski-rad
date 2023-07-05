import 'package:edental/models/appointment.dart';
import 'package:edental/models/dentist.dart';
import 'package:edental/models/treatment.dart';
import 'package:edental/providers/appointmentProvider.dart';
import 'package:edental/providers/auth.dart';
import 'package:edental/providers/dentist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/paymentService.dart';
import '../providers/treatmentProvider.dart';
import 'appointment_item.dart';

class AppointmentDetail extends StatefulWidget {
  AppointmentDetail(this.appointmentItem, this.selectedDentistId, {super.key});
  final AppointmentItem appointmentItem;
  final int? selectedDentistId;
  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  int? selectedDentistId = 0;
  int selectedTreatmentId = 0;
  bool isSaveButtonEnabled = false;
  Dentist? _selectedDentist = null;
  Treatment? _selectedTreatment = null;
  Appointment? makeReservation(int userId) {
    if (isSaveButtonEnabled) {
      Appointment appointment = Appointment(
          0,
          widget.appointmentItem.appointmentHour,
          widget.appointmentItem.appointmentHour.add(const Duration(hours: 1)),
          widget.selectedDentistId ?? _selectedDentist!.id ?? 0,
          _selectedTreatment!.id,
          userId,
          '',
          '',
          '');
      return appointment;
    }
    return null;
  }

  bool enableButtonSaving() {
    return !widget.appointmentItem.IsReserved &&
        selectedDentistId != 0 &&
        selectedTreatmentId != 0;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context);
    final dentistsProvider = Provider.of<DentistProvider>(context);
    final treatment = Provider.of<TreatmentProvider>(context);
    final appointments = Provider.of<AppointmentProvider>(context);
    final paymentService = Provider.of<PaymentService>(context);
    final deviceSize = MediaQuery.of(context).size;
    selectedDentistId = widget.appointmentItem.IsReserved
        ? widget.appointmentItem.appointment!.dentistId
        : appointments.selectedDentistId;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Appointment details',
        ),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: TextFormField(
                  decoration: const InputDecoration(label: Text('Start date')),
                  readOnly: true,
                  initialValue: DateFormat('dd.MM.yyyy H:mm').format(
                      widget.appointmentItem.IsReserved
                          ? widget.appointmentItem.appointment!.start
                          : widget.appointmentItem.appointmentHour),
                ),
              ),
              TextFormField(
                initialValue: DateFormat('dd.MM.yyyy H:mm').format(
                    widget.appointmentItem.IsReserved
                        ? widget.appointmentItem.appointment!.end
                        : widget.appointmentItem.appointmentHour
                            .add(const Duration(hours: 1))),
                decoration: const InputDecoration(label: Text('End date')),
                readOnly: true,
              ),
              FutureBuilder<List<Dentist>>(
                  future: dentistsProvider.getDentistsAsync(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          heightFactor: .3,
                          widthFactor: 0.8,
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  hint: appointments.selectedDentistId != null
                                      ? Text(snapshot.data!
                                          .firstWhere(
                                              (e) => e.id == selectedDentistId)
                                          .fullName)
                                      : const Text('Choose a dentist'),
                                  value: _selectedDentist,
                                  disabledHint: widget
                                              .appointmentItem.IsReserved ||
                                          appointments.selectedDentistId != null
                                      ? Text(snapshot.data!
                                          .firstWhere(
                                              (e) => e.id == selectedDentistId)
                                          .fullName)
                                      : null,
                                  elevation: 2,
                                  items: widget.appointmentItem.IsReserved ||
                                          appointments.selectedDentistId != null
                                      ? null
                                      : dentistsProvider.getDentistsDropdown(),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedDentist = val as Dentist?;
                                      selectedDentistId = val?.id;
                                      isSaveButtonEnabled =
                                          enableButtonSaving();
                                    });
                                  })),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text('No data');
                    }
                    return const Text('This shouldn\'t be displayed');
                  }),
              FutureBuilder<List<Treatment>>(
                  future: treatment.getTreatments(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: DropdownButtonHideUnderline(
                            child: widget.appointmentItem.IsReserved
                                ? DropdownButton(
                                    disabledHint:
                                        widget.appointmentItem.IsReserved
                                            ? Text(snapshot.data!
                                                .firstWhere((e) =>
                                                    e.id ==
                                                    widget.appointmentItem
                                                        .appointment!.dentistId)
                                                .name)
                                            : null,
                                    value: snapshot.data!
                                        .where((e) =>
                                            e.id ==
                                            widget.appointmentItem.appointment!
                                                .dentistId)
                                        .map((e) => DropdownMenuItem(
                                              value: e.id,
                                              child: Text(e.name),
                                            ))
                                        .first,
                                    onChanged: null,
                                    items: [],
                                  )
                                : DropdownButton(
                                    hint: const Text('Choose treatment'),
                                    value: _selectedTreatment,
                                    items: treatment.getDropdown(),
                                    onChanged: (value) => setState(() {
                                          selectedTreatmentId = value.id;
                                          _selectedTreatment = value;
                                          isSaveButtonEnabled =
                                              enableButtonSaving();
                                        }))),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text('No data');
                    }
                    return const Text('How you come here man ?');
                  }),
              !widget.appointmentItem.IsReserved
                  ? ElevatedButton(
                      onPressed: isSaveButtonEnabled
                          ? () async {
                              final existingAppointment =
                                  await appointments.checkExistingAppointment(
                                      selectedDentistId ?? _selectedDentist!.id,
                                      widget.appointmentItem.appointmentHour,
                                      widget.appointmentItem.appointmentHour
                                          .add(const Duration(hours: 1)),
                                      authProvider.user?.id ?? 0);
                              if (existingAppointment != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Appointment is already taken for chosen dentist')));
                                return;
                              }
                              final paymentResult =
                                  await paymentService.payTreatment(
                                      authProvider.user!,
                                      _selectedTreatment!.id,
                                      _selectedTreatment!.price,
                                      _selectedTreatment!.name);
                              if (paymentResult != 'Failure' &&
                                  paymentResult != 'Stripe Cancelled') {
                                await appointments.createAppointment(
                                    makeReservation(
                                        authProvider.user?.id ?? 0));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Payment was successfull')));
                                Navigator.pop(context);
                              } else {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(paymentResult)));
                              }
                            }
                          : null,
                      child: const Text('Make a reservation'))
                  : ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
