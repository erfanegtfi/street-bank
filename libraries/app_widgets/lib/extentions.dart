import 'package:app_widgets/dialog/utils_message.dart';
import 'package:design_system/app_text.dart';
import 'package:flutter/material.dart';

extension ContextTheme on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
}

extension showErrorExtensions on BuildContext {
  showError(String? message, Function() onButtonPressed) {
    if (mounted) UtilsMessage().showError(this, message ?? AppText.errorUnknown, onButtonPressed);
  }
}
