import 'package:flutter/widgets.dart';
import '../../global_widgets/custom_form.dart';
import '../../../data/inputs/sign_up.dart';
import '../../../data/repositories/sign_up_repository.dart';
import '../../../data/responses/sign_up_response.dart';
import '../../../helpers/get.dart';

class RegisterController extends ChangeNotifier {
  String _email = '', _name = '', _lastname = '', _password = '';
  final _repository = Get.i.find<SignUpRepository>();

  GlobalKey<CustomFormState> formKey = GlobalKey();

  void onEmailChanged(String text) {
    _email = text;
  }

  void onNameChanged(String text) {
    _name = text;
  }

  void onLastNameChanged(String text) {
    _lastname = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

  Future<SignUpResponse> submit() async {
    final response = await _repository.register(
      SignUpData(
        name: _name,
        lastname: _lastname,
        email: _email,
        password: _password,
      ),
    );
    // if (response.error == null) {
    //   _s.setUser(response.user!);
    // }
    return response;
  }
}
