import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../global_widgets/circle_button.dart';
import '../../global_widgets/rounded_button.dart';
import '../../../data/repositories/preferences_reposiory.dart';
import '../../../data/providers/remote/google_sign_provider.dart';
import '../../../helpers/get.dart';
import '../../../routes/routes.dart';
import '../../../utils/font_styles.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  Future<void> _setReady() {
    return Get.i.find<PreferencesRepository>().setOnboardAndWelcomeReady(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset('assets/pages/welcome/welcome.svg'),
              )),
              Text(
                'Bienvenido!',
                style: FontStyles.title,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  ' Duis blandit nunc id mauris volutpat tincidunt. Integer convallis finibus ipsum, a mattis mi auctor nec.  ',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        label: 'Ingresar',
                        onPressed: () async {
                          await _setReady();
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.LOGIN, (_) => true);
                        },
                      ),
                    ),
                    SizedBox(width: 25),
                    Expanded(
                      child: RoundedButton(
                        label: 'Registrarse',
                        onPressed: () async {
                          await _setReady();
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.REGISTER, (_) => true);
                        },
                        textColor: Colors.black,
                        borderColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('O vía Redes Sociales'),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    onPressed: () {},
                    iconPath: 'assets/pages/welcome/facebook.svg',
                    backgroundColor: Colors.blue,
                  ),
                  CircleButton(
                    onPressed: () async {
                      final provider = Provider.of<GoogleSignProvider>(context,
                          listen: false);
                      await provider.googleLogin();
                      if (provider.user != null) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.HOME, (route) => true);
                      }
                    },
                    iconPath: 'assets/pages/welcome/google.svg',
                    backgroundColor: Colors.redAccent,
                  ),
                  CircleButton(
                    onPressed: () {},
                    iconPath: 'assets/pages/welcome/apple.svg',
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
