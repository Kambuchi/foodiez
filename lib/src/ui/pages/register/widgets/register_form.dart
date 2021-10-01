import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../register_controller.dart';
import '../../../global_widgets/custom_form.dart';
import '../../../global_widgets/input_text.dart';
import '../../../global_widgets/rounded_button.dart';
import '../../../../utils/dialogs.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  void _submit(BuildContext context) async {
    final controller = context.read<RegisterController>();
    final isFormOk = controller.formKey.currentState!.validate();
    if (isFormOk) {
      ProgressDialog.show(context);
      final isOk = controller.submit();
      if (isOk == false) {
        Dialogs.alert(
          context,
          title: "ERROR",
          description: "El registro falló :(",
        );
      } else {
        Dialogs.alert(
          context,
          title: "BUENAS NOTICIAS",
          dissmisable: false,
          description: "El registro fue exitoso!",
          okText: "OK",
        );
        Navigator.pop(context);
      }
    } else {
      Dialogs.alert(
        context,
        title: "ERROR",
        description: "Campos inválidos",
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
                return text.trim().length > 1 ? null : "Apellido demasiado corto";
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
