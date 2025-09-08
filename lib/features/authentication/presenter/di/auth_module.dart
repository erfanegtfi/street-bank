import 'package:app_data/local/local_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/authentication/domain/usecase/is_user_login_usecase.dart';
import 'package:street_bank/features/authentication/domain/usecase/login_form_validation_usecase.dart';
import 'package:street_bank/features/authentication/domain/usecase/login_user_usecase.dart';

@module
abstract class AuthModule {
  @injectable
  LoginUserUsecase get loginUserUsecase => LoginUserUsecase(locator<LocalStorage>());
  @injectable
  LoginFormValidationUsecase get loginFormValidationUsecase => LoginFormValidationUsecase();
  @injectable
  IsUserLoginUsecase get isUserLoginUsecase => IsUserLoginUsecase(locator<LocalStorage>());
}
