import 'package:app_data/general_error.dart';
import 'package:app_utils/constants.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:app_widgets/dialog/alert_dialog.dart';
import 'package:app_widgets/dialog/utils_message.dart';
import 'package:flutter/material.dart';
import 'package:app_widgets/my_scaffold.dart';
import 'package:app_widgets/input_text_field.dart';
import 'package:app_widgets/buttons/elevated_button_widget.dart';
import 'package:app_utils/validations/form_validators.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_system/export_app_res.dart';
import 'package:app_widgets/extentions.dart';
import 'package:street_bank/app/presenter/providers/my_app_provider.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/presenter/transfer/transfer_provider.dart';
import 'package:street_bank/navigation/navigation_service.dart';

class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  late final StringValidationCallback _nameValidator;
  late final StringValidationCallback _accountNumberValidator;
  late final StringValidationCallback _amountValidator;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    _nameValidator = ValidationBuilder().notEmpty().build();
    _accountNumberValidator = ValidationBuilder().notEmpty().build();
    _amountValidator = ValidationBuilder().notEmpty().build();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setupLoginProviderListener();
    return MyScaffold(
      appBar: AppBar(title: Text(AppText.transferBalanceScreenTitle)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppText.transferBalanceScreenDescription, style: context.textTheme.titleSmall, textAlign: TextAlign.center),
                  const SizedBox(height: 20),

                  MyInputTextField(
                    title: AppText.transferBalanceScreenBeneficiary,
                    validator: _nameValidator,
                    textEditingController: _nameController,
                  ),
                  const SizedBox(height: AppDimen.spacingMedium),
                  MyInputTextField(
                    title: AppText.transferBalanceScreenAccountNumber,
                    validator: _accountNumberValidator,
                    textEditingController: _accountNumberController,
                  ),
                  const SizedBox(height: AppDimen.spacingMedium),
                  MyInputTextField(
                    title: AppText.transferBalanceScreenAmount,
                    validator: _amountValidator,
                    textEditingController: _amountController,
                    inputType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(Constants.currencyInputRegex))],
                  ),
                  const SizedBox(height: AppDimen.spacingXXLarge),
                  getTransferButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getTransferButton() {
    return Consumer(
      builder: (context, ref, __) {
        final reqult = ref.watch(transferProvider);
        return reqult.maybeWhen(
          loading: () => Center(child: CircularProgressIndicator()),
          orElse: () {
            return MyElevatedButton(AppText.transferBalanceScreenSubmit, () {
              if (_formKey.currentState!.validate()) {
                String amount = _amountController.text;
                String name = _nameController.text;
                _confirmTransfer(amount, name);
              }
            });
          },
        );
      },
    );
  }

  _confirmTransfer(String amount, String name) {
    var baseDialog = MyAlertDialog(
      title: AppText.transferBalanceScreenConfirmTitle,
      content: AppText.transferBalanceScreenConfirmMessage.replaceFirst("%s", amount).replaceFirst("%s", name),
      yesOnPressed: () {
        locator<NavigationService>().goBack();
        _transfer();
      },
      noOnPressed: () {
        locator<NavigationService>().goBack();
      },
      yes: AppText.confirm,
      no: AppText.cancel,
    );
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  _transfer() {
    String amount = _amountController.text;
    String accountNumber = _accountNumberController.text;
    String name = _nameController.text;
    ref.read(transferProvider.notifier).transfer(beneficiaryName: name, accountNumber: accountNumber, amount: amount);
  }

  setupLoginProviderListener() {
    ref.listen<ViewState<String>>(transferProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        success: (message) {
          showFlushbar(context: context, title: message);
          locator<NavigationService>().goBack();
        },
        formValidation: (validation) {
          if (!validation.valid) context.showError(validation.errorMessage, () => locator<NavigationService>().goBack());
        },
        error: (GeneralError error) {
          context.showError(error.message, () => locator<NavigationService>().goBack());
        },
      );
    });
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _amountController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
