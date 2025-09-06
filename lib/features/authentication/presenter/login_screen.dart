import 'package:design_system/app_text.dart';
import 'package:flutter/material.dart';
import 'package:app_widgets/my_scaffold.dart';
import 'package:app_widgets/input_text_field.dart';
import 'package:app_widgets/elevated_button_widget.dart';
import 'package:app_utils/validations/form_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_system/export_app_res.dart';
import 'package:app_widgets/extentions.dart';

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

                  MyElevatedButton(AppText.loginScreenFormSubmitBotton, () {
                    if (_formKey.currentState!.validate()) {}
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
