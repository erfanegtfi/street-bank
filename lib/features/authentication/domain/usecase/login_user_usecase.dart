import 'package:app_data/general_error.dart';
import 'package:app_data/local/local_repository.dart';
import 'package:app_data/model/data_response.dart';
import 'package:design_system/app_text.dart';
import 'package:app_utils/constants.dart';
import 'package:street_bank/features/authentication/domain/usecase/params/login_params.dart';

class LoginUserUsecase {
  LocalRepository localRepository;
  LoginUserUsecase(this.localRepository);

  DataResponse<bool> call(LoginFormParam params) {
    if (params.email == Constants.loginEmail && params.password == Constants.loginPass) {
      localRepository.setUserStatus(true);
      return DataResponse.success(true);
    }
    return DataResponse.error(GeneralError.withMessage(AppText.loginFormValidatorInvalidEmailOrPass));
  }
}
