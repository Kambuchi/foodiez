import 'package:flutter/material.dart';
import '../../../data/responses/reset_password_response.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../helpers/get.dart';

class ForgotPasswordController extends ChangeNotifier {
  String _email = "";

  String get email => _email;

  final _repository = Get.i.find<AutheticationRepository>();

  void onEmailChanged(String text) {
    _email = text;
  }

  Future<ResetPasswordResponse> submit() {
    return _repository.sendResetPasswordLink(_email);
  }
}
