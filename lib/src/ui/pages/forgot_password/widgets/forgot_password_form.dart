import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../forgot_password_controller.dart';
import '../../../global_widgets/input_text.dart';
import '../../../global_widgets/rounded_button.dart';
import '../../../../data/responses/reset_password_response.dart';
import '../../../../utils/dialogs.dart';
import '../../../../utils/email_validator.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  void _submit(BuildContext context) async {
    final controller = context.read<ForgotPasswordController>();
    if (isValidEmail(controller.email)) {
      ProgressDialog.show(context);
      final response = await controller.submit();
      Navigator.pop(context);
      if (response == ResetPasswordResponse.ok) {
        await Dialogs.alert(
          context,
          title: "GENIAL",
          description:
              "El correo de recuperación fue enviado a ${controller.email}",
          dissmisable: false,
        );
        Navigator.pop(context);
      } else {
        String errorMessage = "";
        switch (response) {
          case ResetPasswordResponse.networkRequestFailed:
            errorMessage = "Se perdió la conexión a Internet";
            break;
          case ResetPasswordResponse.userDisabled:
            errorMessage = "El usuario está deshabilitado";
            break;
          case ResetPasswordResponse.userNotFound:
            errorMessage = "No se ha encontrado el usuario";
            break;
          case ResetPasswordResponse.tooManyRequests:
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
      }
    } else {
      Dialogs.alert(context, description: "El email no es válido");
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ForgotPasswordController>();
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 330),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SvgPicture.asset(
            'assets/pages/welcome/welcome.png',
            width: 250,
          ),
          InputText(
            prefixIcon: Icon(Icons.email_rounded),
            labelText: "Email",
            onChanged: controller.onEmailChanged,
          ),
          SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RoundedButton(
              onPressed: () => _submit(context),
              label: "Send",
              fullWidth: false,
            ),
          )
        ],
      ),
    );
  }
}
