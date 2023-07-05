import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class RatingSearchRequest {
  int? userId;
  int? dentistId;
  RatingSearchRequest(this.userId, this.dentistId);
}
