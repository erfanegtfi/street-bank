import 'package:app_utils/validator_builder.dart';
import 'package:design_system/app_text.dart';

export 'package:app_utils/validator_builder.dart';

String _emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
int _passwordMinLength = 6;

extension NotEmpty on ValidationBuilder {
  ValidationBuilder notEmpty({String? message}) => add((value) {
    if (value == null || value.isEmpty == true) {
      return message ?? AppText.validatorEmpty;
    } else {
      return null;
    }
  });
}

extension Email on ValidationBuilder {
  ValidationBuilder email({String? message}) => add((value) {
    RegExp regExp = RegExp(_emailPattern);
    if (value == null || value.isEmpty == true) return null;
    if (!regExp.hasMatch(value.trim())) {
      return message ?? AppText.validatorInvalidEmail;
    } else {
      return null;
    }
  });
}

extension PasswordLength on ValidationBuilder {
  password({String? message}) => add((value) {
    if (value == null) return null;
    if (value.trim().length < _passwordMinLength) {
      return message ?? AppText.validatorInvalidLength;
    } else {
      return null;
    }
  });
}
