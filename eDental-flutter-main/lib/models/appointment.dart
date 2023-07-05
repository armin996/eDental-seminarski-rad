import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental/models/dentist.dart';
import 'package:edental/models/treatment.dart';
import 'package:edental/models/user.dart';
import 'package:flutter/material.dart';

import '../helpers/dateJsonFormatter.dart';

@jsonSerializable
class Appointment {
  int id;
  @JsonProperty(converter: CustomDateTimeConverter())
  DateTime start;
  @JsonProperty(converter: CustomDateTimeConverter())
  DateTime end;
  int dentistId;
  int treatmentId;
  int userId;
  String? clientFullName;
  String? dentistFullName;
  String? treatmentName;
  Appointment(
      this.id,
      this.start,
      this.end,
      this.dentistId,
      this.treatmentId,
      this.userId,
      this.clientFullName,
      this.dentistFullName,
      this.treatmentName);
}
