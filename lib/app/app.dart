import 'package:design_system/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:street_bank/features/authentication/presenter/login_screen.dart';
import 'package:design_system/app_text.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: AppText.appName, theme: lightTheme, darkTheme: darkTheme, home: const LoginScreen());
  }
}
