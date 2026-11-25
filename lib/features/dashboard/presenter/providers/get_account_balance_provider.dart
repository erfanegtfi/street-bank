import 'package:app_data/general_error.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/domain/usecase/get_account_balance_usecase.dart';

final getAccountBalanceProvider = StateNotifierProvider.autoDispose<GetAccountBalanceNotifier, AccountBalanceViewState>((ref) {
  GetAccountBalanceUsecase getAccountBalanceUsecase = locator<GetAccountBalanceUsecase>();

  return GetAccountBalanceNotifier(getAccountBalanceUsecase, ref);
});

class GetAccountBalanceNotifier extends StateNotifier<AccountBalanceViewState> {
  final GetAccountBalanceUsecase getAccountBalanceUsecase;

  final Ref ref;

  GetAccountBalanceNotifier(this.getAccountBalanceUsecase, this.ref) : super(AccountBalanceViewState.init());

  getAccountBalance() async {
    state = AccountBalanceViewState.loading();

    double balance = await getAccountBalanceUsecase();

    state = AccountBalanceViewState.success(balance);
  }
}

class AccountBalanceViewState {
  GeneralError? error;
  double? balance;
  bool? loading;

  AccountBalanceViewState.init();
  AccountBalanceViewState.loading() : loading = true;
  AccountBalanceViewState.serverError(this.error) : loading = false;
  AccountBalanceViewState.success(this.balance);

  AccountBalanceViewState({this.error, this.balance, this.loading});
}
