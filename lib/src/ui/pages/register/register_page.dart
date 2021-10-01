import 'package:flutter/material.dart';
import '../../../routes/routes.dart';
import 'package:provider/provider.dart';
import 'register_controller.dart';
import 'widgets/register_form.dart';
import '../../../utils/font_styles.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterController>(
        create: (_) => RegisterController(),
        builder: (_, __) {
          final MediaQueryData data = MediaQuery.of(_);
          final Size size = data.size;
          final padding = data.padding;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(_, Routes.LOGIN, (_)=> true);
                },
              ),
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    constraints: BoxConstraints(
                        minHeight: size.height - padding.top - padding.bottom),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Registrate ya!',
                          style: FontStyles.title,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Completa el formulario con tus datos',
                          style: FontStyles.normal.copyWith(
                              fontWeight: FontWeight.w400, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        RegisterForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
