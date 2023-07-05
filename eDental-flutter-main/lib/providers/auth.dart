import 'package:edental/models/userLogin.dart';
import 'package:edental/providers/authService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../enums/gender.dart';
import '../enums/role.dart';
import '../models/user.dart';

class Auth extends ChangeNotifier {
  AuthService authService = AuthService();
  User? user;
  bool get isAuthenticated => user != null;
  Future<User?> authenticate(String userName, String password) async {
    if (userName.isEmpty || password.isEmpty) {
      return null;
    }
    UserLogin userLogin = UserLogin(userName, password);
    User? loggedUser = await authService.Login(userLogin);
    if (loggedUser == null) {
      return null;
    } else {
      user = loggedUser;
      user?.password = password;
      notifyListeners();
      return loggedUser;
    }
  }

  Future<void> signUp(User userToRegisterOrUpdate) async {
    if (userToRegisterOrUpdate.password !=
        userToRegisterOrUpdate.passwordConfirm) {
      return;
    }
    userToRegisterOrUpdate.id = 0;
    User? confirmedUser = await authService.Register(userToRegisterOrUpdate);
    if (confirmedUser != null) {
      await authenticate(
          confirmedUser.username, userToRegisterOrUpdate.password ?? '');
    }
    notifyListeners();
  }

  Future<void> logout() async {
    user = null;
    notifyListeners();
  }
}
