import 'package:flutter/material.dart';
import 'package:to_do_list/app/exception/auth_exceptions.dart';
import 'package:to_do_list/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({required UserService userService})
      : _userService = userService;

  void registerUser(String email, String password) {
    try {

      error = null;
      success = false;

      // Pode subir uma AuthException
      final user = _userService.register(email: email, password: password);

      if (user != null) {
        success = true;
      } else {
        error = 'Erro ao registrar usuário';
      }

    } on AuthExceptions catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
