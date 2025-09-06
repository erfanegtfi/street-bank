import 'package:app_utils/states/form_validation_state.dart';
import 'package:design_system/app_text.dart';
import 'package:app_utils/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:street_bank/features/authentication/domain/usecase/login_form_validation.dart';

@injectable
class LoginUserUsecase {
  LoginUserUsecase();

  FormValidationState call(LoginFormParam params) {
    if (params.email == Constants.loginEmail && params.password == Constants.loginPass) return FormValidationState.isValid();
    return FormValidationState.errorMessage(AppText.loginFormValidatorInvalidEmailOrPass);
  }
}
