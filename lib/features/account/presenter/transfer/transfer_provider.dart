import 'package:app_data/general_error.dart';
import 'package:app_utils/states/form_validation_state.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:app_utils/utils.dart';
import 'package:app_utils/utils_date.dart';
import 'package:design_system/app_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/domain/usecase/params/transfer_balance_params.dart';
import 'package:street_bank/features/account/domain/usecase/transfer_balance_usecase.dart';
import 'package:street_bank/features/account/domain/usecase/transfer_form_validation_usecase.dart';
import 'package:street_bank/features/dashboard/presenter/providers/get_account_balance_provider.dart';
import 'package:street_bank/features/dashboard/presenter/providers/transaction_list_provider.dart';

final transferProvider = StateNotifierProvider.autoDispose<TransferNotifier, ViewState<String>>((ref) {
  TransferFormValidationUsecase transferFormValidationUsecase = locator<TransferFormValidationUsecase>();
  TransferBalanceUsecase transferBalanceUsecase = locator<TransferBalanceUsecase>();

  return TransferNotifier(transferFormValidationUsecase, transferBalanceUsecase, ref);
});

class TransferNotifier extends StateNotifier<ViewState<String>> {
  final TransferFormValidationUsecase transferFormValidationUsecase;
  final TransferBalanceUsecase transferBalanceUsecase;

  final Ref ref;

  TransferNotifier(this.transferFormValidationUsecase, this.transferBalanceUsecase, this.ref) : super(ViewState.init());

  void transfer({required String amount, required String accountNumber, required String beneficiaryName}) async {
    state = ViewState.loading();

    FormValidationState va = _transferValidateForm(amount: amount, accountNumber: accountNumber, beneficiaryName: beneficiaryName);

    if (va.valid) {
      _doTransfer(amount: amount, accountNumber: accountNumber, beneficiaryName: beneficiaryName);
    }
  }

  FormValidationState _transferValidateForm({required String amount, required String accountNumber, required String beneficiaryName}) {
    FormValidationState va = transferFormValidationUsecase.call(getParams(amount, accountNumber, beneficiaryName));
    state = ViewState.formValidation(va);
    return va;
  }

  void _doTransfer({required String amount, required String accountNumber, required String beneficiaryName}) async {
    state = ViewState.loading();
    bool result = await transferBalanceUsecase(getParams(amount, accountNumber, beneficiaryName));
    if (result) {
      state = ViewState.success(AppText.transferBalanceScreenMessage.replaceFirst("%s", amount).replaceFirst("%s", beneficiaryName));
      _updateDashboard();
    } else
      state = ViewState.error(GeneralError.withMessage(AppText.errorUnknown));
  }

  TransferBalanceParams getParams(String anount, String accountNumber, String beneficiaryName) {
    return TransferBalanceParams(
      id: getRandomID(),
      date: UtilsDate.getCurrentDate(),
      amount: (double.tryParse(anount) ?? 0),
      beneficiaryName: beneficiaryName,
      accountNumber: accountNumber,
    );
  }

  _updateDashboard() {
    ref.read(dashboardTransactionListProvider.notifier).fetchTransactions();
    ref.read(getAccountBalanceProvider.notifier).getAccountBalance();
  }
}
