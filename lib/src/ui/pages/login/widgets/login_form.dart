import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../helpers/get.dart';
import 'package:provider/provider.dart';
import '../../login/login_controller.dart';
import '../../../global_widgets/input_text.dart';
import '../../../global_widgets/rounded_button.dart';
import '../../../../data/models/user.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/dialogs.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  void _submit(BuildContext context) async {
    final controller = context.read<LoginController>();
    ProgressDialog.show(context);
    final User? user = await controller.submit();
    if (user == null) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
              title: Text('Error'),
              content: Text(
                "Invalid username or password",
              )));
    } else {
      Get.i.put<User>(user);
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.HOME,
        (_) => true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context, listen: false);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        children: [
          InputText(
            prefixIcon: Icon(Icons.email),
            keyboardType: TextInputType.emailAddress,
            validator: (text) {
              if (text.contains('@')) return null;
              return "Correo no válido.";
            },
            labelText: "Correo",
            onChanged: controller.onEmailChanged,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 20),
          InputText(
            textInputAction: TextInputAction.send,
            prefixIcon: Icon(Icons.lock_outline),
            labelText: "Contraseña",
            onSubmitted: (text) => _submit(context),
            obscureText: true,
            onChanged: controller.onPasswordChanged,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              child: Text(
                'Olvidó su contraseña? Click aquí',
                style: FontStyles.regular.copyWith(color: primaryColor),
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.FORGOT_PASSWORD);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RoundedButton(
            label: 'Ingresar',
            fullWidth: false,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            onPressed:() => _submit(context),
          ),
        ],
      ),
    );
  }
}
