import 'package:flutter/material.dart';
import 'src/helpers/dependency_injection.dart';
import 'src/my_app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DependencyInjection.initialize();
  runApp(MyApp());
}
