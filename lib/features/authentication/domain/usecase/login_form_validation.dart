import 'package:app_utils/states/form_validation_state.dart';
import 'package:design_system/app_text.dart';
import 'package:app_utils/utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginFormValidationUsecase {
  LoginFormValidationUsecase();

  FormValidationState call(LoginFormParam params) {
    if (checkEmailValidation(params.email ?? "")) return FormValidationState.errorMessage(AppText.validatorInvalidEmail);
    if (checkPasswordValidation(params.password ?? "")) return FormValidationState.errorMessage(AppText.validatorInvalidPasswordLength);
    return FormValidationState.isValid();
  }
}

class LoginFormParam {
  String? email;
  String? password;

  LoginFormParam({this.email, this.password});
}
