import 'package:flutter/widgets.dart';
import '../../global_widgets/custom_form.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/authentication_repository.dart';
import '../../../helpers/get.dart';

class RegisterController extends ChangeNotifier {
  String _email = '', _name = '', _lastname = '';
  final _repository = Get.i.find<AutheticationRepository>();

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

  Future<bool> submit() async {
    return await _repository.register(User(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      email: _email,
      name: _name,
      lastname: _lastname,
      birthday: DateTime(1988, 12,1,),
    ));
  }
}
