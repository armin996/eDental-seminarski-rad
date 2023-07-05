import 'dart:typed_data';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Treatment {
  int id;
  String name;
  double price;
  int timeRequiredInMinutes;
  ByteBuffer? image;

  Treatment(
    this.id,
    this.name,
    this.price,
    this.timeRequiredInMinutes,
    this.image,
  );
}
