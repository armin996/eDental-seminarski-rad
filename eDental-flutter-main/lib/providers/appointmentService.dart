import 'package:edental/apimodels/appointmentSearchRequest.dart';
import 'package:edental/providers/baseProvider.dart';

import '../models/appointment.dart';

class AppointmentService
    extends BaseProvider<Appointment, AppointmentSearchRequest> {
  AppointmentService({apiName = 'appointments', username = '', password = ''})
      : super(apiName, username, password);
}
