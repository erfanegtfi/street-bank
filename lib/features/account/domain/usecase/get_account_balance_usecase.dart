import 'package:app_data/model/data_response.dart';
import 'package:app_data/repository_strategy.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/repositories/account_repository.dart';

class GetAccountBalanceUsecase {
  final AccountRepository accountRepository;

  GetAccountBalanceUsecase({required this.accountRepository});

  Future<double> call() async {
    double? balance = accountRepository.getUserBalance();
    if (balance == null) {
      DataResponse<List<Transaction>?> response = await accountRepository.getAllTransactionsRemote();
      response.when(
        success: (transactions) {
          double sum = 0;
          for (Transaction tran in transactions ?? []) {
            sum += tran.amount ?? 0;
          }
          accountRepository.setUserBalance(sum);
        },
        error: (error) {},
      );
    }
    balance = accountRepository.getUserBalance();
    return balance ?? 0;
  }
}
