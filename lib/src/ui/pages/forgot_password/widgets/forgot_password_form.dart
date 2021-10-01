import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../forgot_password_controller.dart';
import '../../../global_widgets/input_text.dart';
import '../../../global_widgets/rounded_button.dart';
import '../../../../utils/dialogs.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  void _submit(BuildContext context) async {
    final controller = context.read<ForgotPasswordController>();
    ProgressDialog.show(context);
    final sent = await controller.submit();
    Navigator.pop(context);
    if (sent) {
     await Dialogs.alert(
        context,
        title: "GOOD",
        description: "Reset token has sended to ${controller.email}",
        dissmisable: false,
      );
      Navigator.pop(context);
    } else {
      Dialogs.alert(context,
          title: "ERROR", description: "Email: ${controller.email} not found");
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
