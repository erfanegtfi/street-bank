import 'package:app_data/model/index_app_response.dart';
import 'package:app_data/repository_strategy.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/repositories/account_repository.dart';

class TransactionListUsecase {
  final AccountRepository accountRepository;

  TransactionListUsecase({required this.accountRepository});

  Stream<DataResponse<List<Transaction>?>> call(RepositoryStrategy strategy) async* {
    if (strategy == RepositoryStrategy.offlineFirst) {
      yield DataResponse.success(await accountRepository.getAllTransactionsLocal());
      yield await accountRepository.getAllTransactionsRemote();
    } else if (strategy == RepositoryStrategy.offline)
      yield DataResponse.success(await accountRepository.getAllTransactionsLocal());
    else {
      yield await accountRepository.getAllTransactionsRemote();
    }
  }
}
