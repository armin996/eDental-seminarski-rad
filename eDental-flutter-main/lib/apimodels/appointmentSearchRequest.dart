// ignore: file_names
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental/helpers/dateJsonFormatter.dart';

@jsonSerializable
class AppointmentSearchRequest {
  @JsonProperty(ignoreIfNull: true, converter: CustomDateTimeConverter())
  DateTime? start;
  @JsonProperty(ignoreIfNull: true, converter: CustomDateTimeConverter())
  DateTime? end;
  int? dentistId;
  int? treatmentId;
  int? userId;
  String? clientFullName = "";
  String? dentistFullName = "";
  String? treatmentName = "";

  AppointmentSearchRequest({
    this.start,
    this.end,
    this.dentistId,
    this.treatmentId,
    this.userId,
  });
  Map<String, String?> toQueryParams() => {
        'start': start?.toIso8601String(),
        'end': end?.toIso8601String(),
        'dentistId': dentistId.toString(),
        'treatmentId': treatmentId.toString(),
        'clientFullName': clientFullName,
        'treatmentName': treatmentName,
        'dentistFullName': dentistFullName
      };
}
