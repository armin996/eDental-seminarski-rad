import 'dart:typed_data';

import '../enums/gender.dart';
import '../enums/role.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../helpers/dateJsonFormatter.dart';

@jsonSerializable
class User {
  int? id;
  String firstName;
  String lastName;
  String username;
  String? phone;
  String email;
  String? address;
  String? password;
  String? passwordConfirm;
  @JsonProperty(converter: CustomRoleEnumConverter())
  Role? role;
  @JsonProperty(converter: CustomGenderEnumConverter())
  Gender? gender;
  Uint8List? image;
  String get fullName => '$firstName $lastName';
  bool isNotificationEnabled;
  User(
      {this.firstName = '',
      this.lastName = '',
      this.username = '',
      this.phone,
      this.email = '',
      this.address,
      this.password,
      this.passwordConfirm,
      this.role,
      this.gender,
      this.image,
      this.id,
      this.isNotificationEnabled = false});
}
