import 'package:flutter/material.dart';
import 'package:street_bank/features/authentication/presenter/login_screen.dart';
import 'package:design_system/app_text.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppText.appName,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const LoginScreen(),
    );
  }
}
