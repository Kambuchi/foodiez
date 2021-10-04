import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../register_controller.dart';
import '../../../global_widgets/custom_form.dart';
import '../../../global_widgets/input_text.dart';
import '../../../global_widgets/rounded_button.dart';
import '../../../../data/responses/sign_up_response.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/dialogs.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  void _submit(BuildContext context) async {
    final controller = context.read<RegisterController>();
    final isFormOk = controller.formKey.currentState!.validate();
    if (isFormOk) {
      ProgressDialog.show(context);
      final response = await controller.submit();
      if (response.error != null) {
        late String content;
        switch (response.error) {
          case SignUpError.emailAlreadyInUse:
            content = "Esta dirección de correo ya está utilizada";
            break;
          case SignUpError.weakPassword:
            content = "El password es muy débil";
            break;
          case SignUpError.networkRequestFailed:
            content = "Se perdió la conexión a Internet";
            break;
          default:
            content = "Error desconocido";
            break;
        }
        Dialogs.alert(
          context,
          title: "ERROR",
          description: content,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.HOME,
          (_) => true,
        );
      }
    } else {
      Dialogs.alert(
        context,
        title: "ERROR",
        description: "Campos no válidos",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterController>();
    return CustomForm(
      key: controller.formKey,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 330),
        child: Column(
          children: [
            InputText(
              prefixIcon: Icon(Icons.person_outline),
              onChanged: controller.onNameChanged,
              labelText: "Nombre",
              validator: (text) {
                return text.trim().length > 1 ? null : "Nombre demasiado corto";
              },
            ),
            SizedBox(
              height: 15,
            ),
            InputText(
              prefixIcon: Icon(Icons.person_add_outlined),
              onChanged: controller.onLastNameChanged,
              labelText: "Apellido",
              validator: (text) {
                return text.trim().length > 1
                    ? null
                    : "Apellido demasiado corto";
              },
            ),
            SizedBox(
              height: 15,
            ),
            InputText(
              prefixIcon: Icon(Icons.email_outlined),
              onChanged: controller.onEmailChanged,
              labelText: "Correo",
              validator: (text) {
                return text.contains('@') ? null : "Correo no válido";
              },
            ),
            SizedBox(
              height: 15,
            ),
            InputText(
              prefixIcon: Icon(Icons.lock_outlined),
              onChanged: controller.onPasswordChanged,
              labelText: "Contraseña",
              obscureText: true,
              validator: (text) {
                if (text.trim().length >= 6) {
                  return null;
                }
                return "Password no válido";
              },
            ),
            // SizedBox(
            //   height: 15,
            // ),
            // Consumer(builder: (_, watch, __) {
            //   return InputText(
            //     prefixIcon: Icon(Icons.lock_outlined),
            //     labelText: "Verificación de Password",
            //     onChanged: controller.onVPasswordChanged,
            //     obscureText: true,
            //     validator: (text) {
            //       if (controller.onPasswordChanged != text) {
            //         return "Los passwords no coinciden";
            //       }
            //       if (text.trim().length >= 6) {
            //         return null;
            //       }
            //       return "Password no coincide";
            //     },
            //   );
            // }),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RoundedButton(
                label: "Registrarse",
                fullWidth: false,
                onPressed: () {
                  _submit(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
