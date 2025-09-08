import 'package:app_utils/states/form_validation_state.dart';
import 'package:design_system/app_text.dart';
import 'package:street_bank/features/account/data/data_source/local/account_local_storage_impl.dart';
import 'package:street_bank/features/account/domain/usecase/params/transfer_balance_params.dart';

class TransferFormValidationUsecase {
  final AccountLocalStorage accountLocalStorage;
  TransferFormValidationUsecase({required this.accountLocalStorage});

  FormValidationState call(TransferBalanceParams params) {
    if (params.amount.toDouble() <= 0) return FormValidationState.errorMessage(AppText.transferBalanceScreenInvalidAmount);

    if (!_userHasEnoughBalance(params)) return FormValidationState.errorMessage(AppText.transferBalanceScreenInsafficientBalance);

    return FormValidationState.isValid();
  }

  bool _userHasEnoughBalance(TransferBalanceParams params) {
    double balance = accountLocalStorage.getUserBalance() ?? 0;
    return (balance >= params.amount.toDouble());
  }
}
