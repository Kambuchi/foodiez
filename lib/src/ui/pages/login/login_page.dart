import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'login_controller.dart';
import '../../../utils/font_styles.dart';
import 'widgets/login_form.dart';
import 'widgets/social_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginController>(
      create: (context) => LoginController(),
      builder: (context, __) {
        final size = MediaQuery.of(context).size;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  // alignment: Alignment.center,
                  width: double.infinity,
                  height: size.height * 0.95,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Bienvenido de vuelta!',
                        style: FontStyles.title,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: SvgPicture.asset(
                            'assets/pages/welcome/welcome.svg',
                          ),
                        ),
                      ),
                      LoginForm(),
                      SocialLogin(),
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
