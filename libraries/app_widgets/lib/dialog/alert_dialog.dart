// ignore_for_file: must_be_immutable

import 'package:app_widgets/buttons/text_button_widget.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  String? title;
  String content;
  String yes;
  String? no;
  TextAlign? textAlign;
  Function yesOnPressed;
  Function? noOnPressed;

  MyAlertDialog({
    this.title,
    required this.content,
    required this.yesOnPressed,
    required this.yes,
    this.noOnPressed,
    this.no,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AlertDialog(
      title: title != null ? Text(title!) : null,
      titleTextStyle: theme.textTheme.bodyLarge,
      content: Text(content, style: theme.textTheme.bodyMedium, textAlign: textAlign),
      backgroundColor: appColors().screenBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimen.radiusNormal)),
      actions: <Widget>[
        MyTextButton(yes, () {
          yesOnPressed();
        }),
        if (no?.isNotEmpty == true)
          MyTextButton(no!, () {
            if (noOnPressed != null) noOnPressed!();
          }),
      ],
    );
  }
}
