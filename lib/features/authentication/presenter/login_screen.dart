import 'package:flutter/material.dart';
import 'package:app_widgets/my_scaffold.dart';
import 'package:app_utils/validations/form_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final emailValidator;
  late final passValidator;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailValidator = ValidationBuilder().notEmpty().email().build();
    passValidator = ValidationBuilder().notEmpty().password().build();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
