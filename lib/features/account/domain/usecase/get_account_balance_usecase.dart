import 'package:app_data/model/data_response.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/repositories/account_repository.dart';

class GetAccountBalanceUsecase {
  final AccountRepository accountRepository;

  GetAccountBalanceUsecase({required this.accountRepository});

  Future<double> call() async {
    double? balance = accountRepository.getUserBalance();
    balance ??= await getWalletBalanceFromRemoteTransaction();

    return balance;
  }

  Future<double> getWalletBalanceFromRemoteTransaction() async {
    DataResponse<List<Transaction>?> response = await accountRepository.getAllTransactionsRemote();
    response.when(
      success: (transactions) {
        accountRepository.setUserBalance(_getTotalBalance(transactions));
      },
      error: (error) {},
    );
    return accountRepository.getUserBalance() ?? 0;
  }

  // get account balance
  double _getTotalBalance(List<Transaction>? transactions) {
    double sum = 0;
    for (Transaction tran in transactions ?? []) {
      sum += tran.amount ?? 0;
    }
    return sum;
  }
}
