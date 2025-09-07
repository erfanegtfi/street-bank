import 'package:app_widgets/extentions.dart';
import 'package:app_widgets/my_background_widget.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;
  const HeaderButton({required this.title, required this.icon, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return MyBackground(
      colorBack: appColors().white.withAlpha(80),
      colorBorder: Colors.transparent,
      width: 120,
      child: InkWell(
        onTap: () => onPressed(),
        child: Column(
          children: [
            Icon(icon, color: appColors().white),
            SizedBox(height: AppDimen.spacingSmall),
            Text(title, style: context.textTheme.bodyLarge?.copyWith(color: appColors().white)),
          ],
        ),
      ),
    );
  }
}
