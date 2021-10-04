import 'package:flutter/material.dart';
import '../ui/pages/home/tabs/home_tab/widgets/search_result.dart';
import '../ui/pages/cart/cart_page.dart';
import '../ui/pages/dish/dish_page.dart';
import '../ui/pages/home/home_page.dart';
import '../ui/pages/forgot_password/forgot_password_page.dart';
import '../ui/pages/register/register_page.dart';
import '../ui/pages/welcome/welcome_page.dart';
import '../ui/pages/login/login_page.dart';
import '../ui/pages/onboard/onboard_page.dart';
import '../routes/routes.dart';

abstract class Pages {
  static const String INITIAL = Routes.ONBOARD;
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.ONBOARD: (_) => OnboardPage(),
    Routes.WELCOME: (_) => WelcomePage(),
    Routes.LOGIN: (_) => LoginPage(),
    Routes.REGISTER: (_) => RegisterPage(),
    Routes.FORGOT_PASSWORD: (_) => ForgotPasswordPage(),
    Routes.HOME: (_) => HomePage(),
    Routes.DISH: (_) => DishPage(),
    Routes.CART: (_) => CartPage(),
    // Routes.SPLASH: (_) => SplashPage(),
    Routes.SEARCH_RESULT: (_) => SearchResult(),
  };
}
