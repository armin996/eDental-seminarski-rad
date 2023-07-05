import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class UserLogin {
  String username;
  String password;

  UserLogin(
    this.username,
    this.password,
  );
}
