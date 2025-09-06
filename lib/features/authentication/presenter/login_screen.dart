import 'package:app_data/general_error.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:app_widgets/dialog/utils_message.dart';
import 'package:flutter/material.dart';
import 'package:app_widgets/my_scaffold.dart';
import 'package:app_widgets/input_text_field.dart';
import 'package:app_widgets/buttons/elevated_button_widget.dart';
import 'package:app_utils/validations/form_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_system/export_app_res.dart';
import 'package:app_widgets/extentions.dart';
import 'package:street_bank/features/authentication/domain/usecase/params/login_params.dart';
import 'package:street_bank/features/authentication/presenter/login_provider.dart';

import 'widgets/header_logo_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final StringValidationCallback _emailValidator;
  late final StringValidationCallback _passValidator;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _emailValidator = ValidationBuilder().notEmpty().email().build();
    _passValidator = ValidationBuilder().notEmpty().password().build();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setupLoginProviderListener();
    return MyScaffold(
      body: ListView(
        children: [
          const LoginHeaderLogo(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppText.loginScreenTitle, style: context.textTheme.titleLarge, textAlign: TextAlign.center),
                  const SizedBox(height: 20),

                  MyInputTextField(
                    title: AppText.loginScreenFormHintEmail,
                    validator: _emailValidator,
                    textEditingController: _emailController,
                  ),
                  const SizedBox(height: AppDimen.spacingMedium),
                  MyInputTextField(
                    title: AppText.loginScreenFormHintPassword,
                    isSecure: true,
                    validator: _passValidator,
                    textEditingController: _passwordController,
                  ),
                  const SizedBox(height: AppDimen.spacingXXLarge),
                  getLoginButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getLoginButton() {
    return Consumer(
      builder: (context, ref, __) {
        final reqult = ref.watch(loginProvider);
        return reqult.maybeWhen(
          loading: () => Center(child: CircularProgressIndicator()),
          orElse: () {
            return MyElevatedButton(AppText.loginScreenFormSubmitBotton, () {
              if (_formKey.currentState!.validate()) {
                ref.read(loginProvider.notifier).loginValidateForm(getParam());
              }
            });
          },
        );
      },
    );
  }

  LoginFormParam getParam() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    return LoginFormParam(email: email, password: password);
  }

  setupLoginProviderListener() {
    ref.listen<ViewState<String>>(loginProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        success: (message) {
          showFlushbar(context: context, title: message);
        },
        formValidation: (validation) {
          if (validation.valid)
            ref.read(loginProvider.notifier).login(getParam());
          else
            context.showError(validation.errorMessage, () {});
        },
        error: (GeneralError error) {
          context.showError(error.message, () {});
        },
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
