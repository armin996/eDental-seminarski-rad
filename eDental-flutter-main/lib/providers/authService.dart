import 'dart:async';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental/models/userLogin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../models/user.dart';
import 'baseProvider.dart';

class AuthService extends BaseProvider<UserLogin, Object> {
  AuthService({apiName = 'auth', username = '', password = ''})
      : super(apiName, username, password);

  Future<User?> Login(UserLogin userLogin) async {
    String? apiUrl = dotenv.env['API_URL'];
    Response res = await http.post(Uri.parse('$apiUrl/auth/login'),
        headers: super.headers, body: JsonMapper.serialize(userLogin));
    try {
      var result = JsonMapper.deserialize<User>(res.body);
      return result;
    } catch (Exception) {
      return null;
    }
  }

  Future<User?> Register(User userLogin) async {
    String? apiUrl = dotenv.env['API_URL'];
    Response res = await http.post(Uri.parse('$apiUrl/auth/register'),
        headers: super.headers, body: JsonMapper.serialize(userLogin));
    return JsonMapper.deserialize<User>(res.body);
  }
}

class UserService extends BaseProvider<User, Object> {
  UserService({apiName = 'users', username = '', password = ''})
      : super(apiName, username, password);
}
