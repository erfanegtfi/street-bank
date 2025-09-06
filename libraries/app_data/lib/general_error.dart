import 'package:design_system/app_text.dart';
import 'package:flutter/foundation.dart';

class GeneralError {
  int? _errorCode;
  String _message = "";

  int? get errorCode => _errorCode;

  set message(String value) {
    _message = value;
  }

  String get message {
    if (_message.isNotEmpty) {
      return _message;
    } else {
      _message = AppText.errorUnknown;

      return _message;
    }
  }

  GeneralError._();

  GeneralError.withMessage(String? message) {
    if (message?.isNotEmpty == true) _message = message!;
    if (!kReleaseMode) {
      debugPrint(message);
    }
  }
}
