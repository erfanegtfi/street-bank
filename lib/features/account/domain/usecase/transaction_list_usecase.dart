import 'package:app_data/model/index_app_response.dart';
import 'package:app_data/repository_strategy.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/repositories/account_repository.dart';

class TransactionListUsecase {
  final AccountRepository accountRepository;

  TransactionListUsecase({required this.accountRepository});

  Future<void> call(RepositoryStrategy strategy, void Function(DataResponse<List<Transaction>?> response) callback) async {
    if (strategy == RepositoryStrategy.remote) callback(await accountRepository.getAllTransactionsRemote());
    if (strategy == RepositoryStrategy.offline) callback(DataResponse.success(await accountRepository.getAllTransactionsLocal()));
    if (strategy == RepositoryStrategy.offlineFirst) {
      callback(DataResponse.success(await accountRepository.getAllTransactionsLocal()));
      callback(await accountRepository.getAllTransactionsRemote());
    }
  }
}
