import 'package:app_utils/states/view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/domain/usecase/get_account_balance_usecase.dart';

final getAccountBalanceProvider = StateNotifierProvider.autoDispose<GetAccountBalanceNotifier, ViewState<double>>((ref) {
  GetAccountBalanceUsecase getAccountBalanceUsecase = locator<GetAccountBalanceUsecase>();

  return GetAccountBalanceNotifier(getAccountBalanceUsecase, ref);
});

class GetAccountBalanceNotifier extends StateNotifier<ViewState<double>> {
  final GetAccountBalanceUsecase getAccountBalanceUsecase;

  final Ref ref;

  GetAccountBalanceNotifier(this.getAccountBalanceUsecase, this.ref) : super(ViewState.init());

  getAccountBalance() async {
    state = ViewState.loading();

    double balance = await getAccountBalanceUsecase();

    state = ViewState.success(balance);
  }
}
