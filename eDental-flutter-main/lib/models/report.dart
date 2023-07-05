import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Report {
  String dentistFullName;
  double averageRate;

  Report(
    this.dentistFullName,
    this.averageRate,
  );
}
