// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import '../../../data/models/user.dart';
// import '../../../data/repositories/account_repository.dart';
// import '../../../data/repositories/authentication_repository.dart';
// import '../../../data/repositories/preferences_reposiory.dart';
// import '../../../helpers/get.dart';

// class SplashController extends ChangeNotifier {
//   final _preferencesRepository = Get.i.find<PreferencesRepository>();
//   final _autheticationRepository = Get.i.find<AutheticationRepository>();
//   final _accountRepository = Get.i.find<AccountRepository>();

//   void Function(User? user, bool isReady)? onAfterFirstLayout;

//   void afterFirstLayout() async {
//     await Future.delayed(Duration(seconds: 3));
//     final token = _autheticationRepository.token;
//     if (token != null) {
//       // final User? user = await _accountRepository.userInformation;
//       if (user != null) {
//         if (onAfterFirstLayout != null) {
//           onAfterFirstLayout!(user, true);
//           return;
//         }
//       }
//     }
//     final isReady = _preferencesRepository.OnboardAndWelcomeReady;
//     if (onAfterFirstLayout != null) {
//       onAfterFirstLayout!(null, isReady);
//     }
//   }
// }
