import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/repositories/account_repository.dart';

class TransactionListStreamUsecase {
  final AccountRepository accountRepository;

  TransactionListStreamUsecase({required this.accountRepository});

  Stream<List<Transaction>?> call() {
    return accountRepository.getAllTransactionsAsStream();
  }
}
