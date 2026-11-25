import 'package:app_data/general_error.dart';
import 'package:app_data/model/data_response.dart';
import 'package:app_utils/states/form_validation_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/authentication/domain/usecase/login_form_validation_usecase.dart';
import 'package:street_bank/features/authentication/domain/usecase/login_user_usecase.dart';
import 'package:street_bank/features/authentication/domain/usecase/params/login_params.dart';

final loginProvider = StateNotifierProvider.autoDispose<LoginNotifier, LoginViewState>((ref) {
  LoginFormValidationUsecase loginFormValidationUsecase = locator<LoginFormValidationUsecase>();
  LoginUserUsecase loginUserUsecase = locator<LoginUserUsecase>();

  return LoginNotifier(loginFormValidationUsecase, loginUserUsecase, ref);
});

class LoginNotifier extends StateNotifier<LoginViewState> {
  final LoginFormValidationUsecase loginFormValidationUsecase;
  final LoginUserUsecase loginUserUsecase;

  final Ref ref;

  LoginNotifier(this.loginFormValidationUsecase, this.loginUserUsecase, this.ref) : super(LoginViewState.init());

  void login({required String email, required String password}) async {
    state = LoginViewState.loading();

    FormValidationState va = _loginValidateForm(email: email, password: password);
    if (va.valid) _doLogin(getParam(email: email, password: password));
  }

  FormValidationState _loginValidateForm({required String email, required String password}) {
    FormValidationState va = loginFormValidationUsecase.call(getParam(email: email, password: password));
    state = LoginViewState.formError(va);
    return va;
  }

  void _doLogin(LoginFormParam param) async {
    state = LoginViewState.loading();
    DataResponse<bool> result = loginUserUsecase(param);
    result.when(
      success: (data) {
        state = LoginViewState.success(true);
      },
      error: (error) {
        state = LoginViewState.serverError(error);
      },
    );
  }

  LoginFormParam getParam({required String email, required String password}) {
    return LoginFormParam(email: email, password: password);
  }
}

class LoginViewState {
  GeneralError? error;
  FormValidationState? formError;
  bool? successLogin;
  bool? loading;

  LoginViewState.init();
  LoginViewState.loading() : loading = true;
  LoginViewState.serverError(this.error) : loading = false;
  LoginViewState.formError(this.formError);
  LoginViewState.success(this.successLogin);

  LoginViewState({this.error, this.successLogin, this.loading});
}
