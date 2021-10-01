import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'forgot_password_controller.dart';
import 'widgets/forgot_password_form.dart';
import '../../../utils/font_styles.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordController>(
      create: (_) => ForgotPasswordController(),
      builder: (_, __) {
        final MediaQueryData data = MediaQuery.of(_);
        final Size size = data.size;
        final padding = data.padding;
        final AppBar appBar =AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );

        return Scaffold(
          appBar: appBar,
          body: SafeArea(
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: ()=> FocusScope.of(context).unfocus(),
                child: Container(
                  width: double.infinity,
                  height: size.height -padding.top - padding.bottom-appBar.preferredSize.height,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Forgot Password',
                        style: FontStyles.title.copyWith(fontSize: 22),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                        child: Text(
                          'Quisque id cursus felis. Cras vehicula congue molestie. Sed vitae justo metus. Curabitur posuere nibh lacus, et iaculis diam facilisis non.',
                          style: FontStyles.normal.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ForgotPasswordForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
