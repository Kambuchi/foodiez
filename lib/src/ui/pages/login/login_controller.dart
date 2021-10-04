import 'package:flutter/material.dart';
import '../../../data/responses/sign_in_response.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../helpers/get.dart';

class LoginController extends ChangeNotifier {
  String _email = '', _password = '';
  final _authenticationRepository = Get.i.find<AutheticationRepository>();

  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SignInResponse?> submit() async {
    await _authenticationRepository.signInWithEmailAndPassword(
        _email, _password);
  }
}
