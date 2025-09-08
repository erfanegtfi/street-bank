import 'package:app_data/model/data_response.dart';
import 'package:app_utils/states/form_validation_state.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:design_system/app_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/authentication/domain/usecase/login_form_validation_usecase.dart';
import 'package:street_bank/features/authentication/domain/usecase/login_user_usecase.dart';
import 'package:street_bank/features/authentication/domain/usecase/params/login_params.dart';

final loginProvider = StateNotifierProvider.autoDispose<LoginNotifier, ViewState<String>>((ref) {
  LoginFormValidationUsecase loginFormValidationUsecase = locator<LoginFormValidationUsecase>();
  LoginUserUsecase loginUserUsecase = locator<LoginUserUsecase>();

  return LoginNotifier(loginFormValidationUsecase, loginUserUsecase, ref);
});

class LoginNotifier extends StateNotifier<ViewState<String>> {
  final LoginFormValidationUsecase loginFormValidationUsecase;
  final LoginUserUsecase loginUserUsecase;

  final Ref ref;

  LoginNotifier(this.loginFormValidationUsecase, this.loginUserUsecase, this.ref) : super(ViewState.init());

  FormValidationState _loginValidateForm({required String email, required String password}) {
    FormValidationState va = loginFormValidationUsecase.call(getParam(email: email, password: password));
    state = ViewState.formValidation(va);
    return va;
  }

  void login({required String email, required String password}) async {
    state = ViewState.loading();

    FormValidationState va = _loginValidateForm(email: email, password: password);
    if (va.valid) _doLogin(getParam(email: email, password: password));
  }

  void _doLogin(LoginFormParam param) async {
    state = ViewState.loading();
    DataResponse<bool> result = loginUserUsecase(param);
    result.when(
      success: (data) {
        state = ViewState.success(AppText.loginSuccessMessage);
      },
      error: (error) {
        state = ViewState.error(error);
      },
    );
  }

  LoginFormParam getParam({required String email, required String password}) {
    return LoginFormParam(email: email, password: password);
  }
}
