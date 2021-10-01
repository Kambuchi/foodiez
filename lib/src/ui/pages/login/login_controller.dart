import 'package:flutter/material.dart';
import '../../../data/repositories/account_repository.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../data/models/user.dart';
import '../../../helpers/get.dart';

class LoginController extends ChangeNotifier {
  String _email = '', _password = '';
  final _authenticationRepository = Get.i.find<AutheticationRepository>();
  final _accountRepository = Get.i.find<AccountRepository>();

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<User?> submit() async {
    final String? token =
        await _authenticationRepository.login(_email, _password);
    if (token != null) {
      await _authenticationRepository.saveToken(token);
      return _accountRepository.userInformation;
    }
    return null;
  }
}
