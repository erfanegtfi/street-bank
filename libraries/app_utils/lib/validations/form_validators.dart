import 'package:app_utils/utils.dart';
import 'package:app_utils/validator_builder.dart';
import 'package:design_system/app_text.dart';

export 'package:app_utils/validator_builder.dart';
export 'package:app_utils/utils.dart';

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
    if (value == null) return null;
    if (!checkEmailValidation(value)) {
      return message ?? AppText.validatorInvalidEmail;
    } else {
      return null;
    }
  });
}

extension PasswordLength on ValidationBuilder {
  password({String? message}) => add((value) {
    if (value == null) return null;
    if (!checkPasswordValidation(value)) {
      return message ?? AppText.validatorInvalidPasswordLength;
    } else {
      return null;
    }
  });
}
