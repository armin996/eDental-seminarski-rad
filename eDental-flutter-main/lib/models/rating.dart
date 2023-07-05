import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental/helpers/dateJsonFormatter.dart';

@jsonSerializable
class Rating {
  int? id;
  int rate;
  String comment;
  @JsonProperty(converter: CustomDateTimeConverter())
  DateTime date;
  int userId;
  int dentistId;
  @JsonProperty(ignoreIfNull: true)
  String? dentistFullName;
  @JsonProperty(ignoreIfNull: true)
  String? clientFullName;

  Rating(
    this.rate,
    this.comment,
    this.date,
    this.userId,
    this.dentistId, {
    this.id,
    this.dentistFullName,
    this.clientFullName,
  });
}
