import 'package:dart_json_mapper/dart_json_mapper.dart';
import '../helpers/dateJsonFormatter.dart';

@jsonSerializable
class PaymentSearchRequestDto {
  @JsonProperty(converter: CustomDateTimeConverter(), ignoreIfNull: true)
  DateTime? date;
  int? userId;
  String cardNumber;
  @JsonProperty(ignoreIfNull: true)
  int? treatmentId;
  String client;
  String treatmentName;

  PaymentSearchRequestDto(this.date, this.userId,
      {this.treatmentName = '',
      this.cardNumber = '',
      this.treatmentId,
      this.client = ''});
}
