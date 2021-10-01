import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'helpers/dependency_injection.dart';
import 'ui/global_controller/notifications_controller.dart';
import 'ui/global_controller/cart_controller.dart';
import 'package:provider/provider.dart';
import 'routes/pages.dart';
import 'utils/colors.dart';
import 'utils/font_styles.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    DependencyInjection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartController>(create: (_) => CartController()),
        ChangeNotifierProvider<NotificationsController>(
            create: (_) => NotificationsController()),
      ],
      child: MaterialApp(
        title: 'Foodiez',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: primaryColor,
          textTheme: FontStyles.textTheme,
          primarySwatch: Colors.cyan,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cupertinoOverrideTheme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              textStyle: FontStyles.normal,
            ),
          ),
        ),
        initialRoute: Pages.INITIAL,
        routes: Pages.routes,
      ),
    );
  }
}
