import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../login/login_controller.dart';
import '../../../global_widgets/input_text.dart';
import '../../../global_widgets/rounded_button.dart';
import '../../../../data/responses/sign_in_response.dart';
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
    final response = await controller.submit();
    if (response?.error != null) {
      late String errorMessage = "";
      switch (response?.error) {
        case SignInError.networkRequestFailed:
          errorMessage = "Se perdió la conexión a Internet";
          break;
        case SignInError.userDisabled:
          errorMessage = "El usuario está deshabilitado";
          break;
        case SignInError.userNotFound:
          errorMessage = "No se ha encontrado el usuario";
          break;
        case SignInError.wrongPassword:
          errorMessage = "El password es incorrecto";
          break;
        case SignInError.tooManyRequests:
          errorMessage = "Demasiadas solicitudes equivocadas";
          break;
        default:
          errorMessage = "Error desconocido";
          break;
      }

      Dialogs.alert(
        context,
        title: "ERROR",
        description: errorMessage,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.HOME,
        (_) => false,
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
            onPressed: () => _submit(context),
          ),
        ],
      ),
    );
  }
}
