import 'package:app_data/model/data_response.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/repositories/account_repository.dart';

class TransactionListUsecase {
  final AccountRepository accountRepository;

  TransactionListUsecase({required this.accountRepository});

  Future<DataResponse<List<Transaction>?>> call() async {
    return accountRepository.getAllTransactionsRemote();
  }
}
