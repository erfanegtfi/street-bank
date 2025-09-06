import 'package:app_widgets/extentions.dart';
import 'package:design_system/app_text.dart';
import 'package:flutter/material.dart';

class LoginHeaderLogo extends StatelessWidget {
  const LoginHeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.attach_money, size: 60),
          Text(AppText.loginScreenStreetBank, style: context.textTheme.headlineLarge),
        ],
      ),
    );
  }
}
