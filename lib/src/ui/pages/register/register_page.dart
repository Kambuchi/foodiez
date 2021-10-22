import 'package:flutter/material.dart';
import 'package:foodiez/src/utils/colors.dart';
import 'package:foodiez/src/utils/responsive.dart';
import 'package:foodiez/src/widgets/header.dart';
import '../../../routes/routes.dart';
import 'package:provider/provider.dart';
import 'register_controller.dart';
import 'widgets/register_form.dart';
import '../../../utils/font_styles.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return ChangeNotifierProvider<RegisterController>(
        create: (_) => RegisterController(),
        builder: (_, __) {
          final MediaQueryData data = MediaQuery.of(_);
          final Size size = data.size;
          final padding = data.padding;
          return Scaffold(
            // appBar: AppBar(
            //   backgroundColor: primaryColor,
            //   elevation: 0,

            // ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            _, Routes.LOGIN, (_) => true);
                      },
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        Container(
                          height: responsive.hp(20),
                          child: HeaderWidget(
                              responsive.hp(20),
                              false,
                              Icons
                                  .login_rounded), //let's create a common header widget
                        ),
                        SafeArea(
                          child: Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            constraints: BoxConstraints(
                                minHeight:
                                    size.height - padding.top - padding.bottom),
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
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                                RegisterForm(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]))
                ],
              ),
            ),
          );
        });
  }
}
