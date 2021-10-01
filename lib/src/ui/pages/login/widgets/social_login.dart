
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../global_widgets/circle_button.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/font_styles.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text('O vía Redes Sociales'),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleButton(
              onPressed: () {},
              iconPath: 'assets/pages/welcome/facebook.svg',
              backgroundColor: Colors.blue,
            ),
            CircleButton(
              onPressed: () {},
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
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("Todavía no tienes una cuenta?"),
            CupertinoButton(
                child: Text('Registraste Aquí', style: FontStyles.regular),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.REGISTER);
                }),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
