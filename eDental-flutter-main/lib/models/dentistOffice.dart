import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class DentistOffice {
  int id;
  String name;
  String address;
  String phone;
  String email;
  String description;

  DentistOffice(
    this.id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.description,
  );
}
