import 'package:street_bank/features/account/domain/repositories/account_repository.dart';
import 'package:street_bank/features/account/domain/usecase/params/transfer_balance_params.dart';

class TransferBalanceUsecase {
  final AccountRepository accountRepository;

  TransferBalanceUsecase({required this.accountRepository});

  Future<bool> call(TransferBalanceParams params) async {
    double finalBalance = _getAccountFinalBalance(params.amount);
    if (finalBalance < 0) return false;
    accountRepository.setUserBalance(finalBalance);

    params.amount = -params.amount;
    bool response = await accountRepository.addTransaction(params);
    return response;
  }

  _getAccountFinalBalance(double amount) {
    double balance = accountRepository.getUserBalance() ?? 0;
    return balance - amount;
  }
}
