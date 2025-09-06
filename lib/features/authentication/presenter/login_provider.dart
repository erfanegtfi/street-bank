import 'package:app_utils/states/form_validation_state.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/app/di/injector.dart';
import 'package:street_bank/features/authentication/domain/usecase/login_form_validation.dart';

final loginProvider = StateNotifierProvider.autoDispose<LoginNotifier, ViewState<bool>>((ref) {
  LoginFormValidationUsecase loginFormValidationUsecase = serviceLocator<LoginFormValidationUsecase>();

  return LoginNotifier(loginFormValidationUsecase, ref);
});

class LoginNotifier extends StateNotifier<ViewState<bool>> {
  final LoginFormValidationUsecase loginFormValidationUsecase;

  final Ref ref;

  LoginNotifier(this.loginFormValidationUsecase, this.ref) : super(ViewState.init());

  loginValidateForm(LoginFormParam param) {
    FormValidationState va = loginFormValidationUsecase.call(param);
    state = ViewState.formValidation(va);
  }

  void login(LoginFormParam swap) async {
    state = ViewState.loading();
  }
}
