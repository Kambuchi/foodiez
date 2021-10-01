import 'dart:async';
import '../../models/user.dart';

class AuthenticationProvider {
  Future<String?> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));
    if (email == "test@test.com" && password == "test") {
      final token = DateTime.now().microsecondsSinceEpoch.toString();
      return token;
    }
    return null;
  }

  Future<bool> register(User user) async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  Future<bool> sendResetToken(String email) async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}
