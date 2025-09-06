import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final String title;
  final Color? backColor;
  final TextStyle? textStyle;
  final Function() onPressed;

  const MyElevatedButton(this.title, this.onPressed, {this.textStyle, this.backColor, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backColor ?? appColors().primary,
        minimumSize: Size(double.infinity, AppDimen.buttonHeight),
        // foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimen.radiusNormal)),
      ),
      onPressed: onPressed,
      child: Text(title, style: textStyle),
    );
  }
}
