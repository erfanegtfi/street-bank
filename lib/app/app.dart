import 'package:design_system/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:design_system/app_text.dart';
import 'package:street_bank/features/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: AppText.appName, theme: lightTheme, darkTheme: darkTheme, home: const MyHomePage());
  }
}
