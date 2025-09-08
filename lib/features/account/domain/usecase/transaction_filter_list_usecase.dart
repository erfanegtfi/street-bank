import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/repositories/account_repository.dart';
import 'package:street_bank/features/account/domain/usecase/params/transaction_filter_params.dart';
import 'package:street_bank/features/account/domain/usecase/params/transaction_type.dart';

class TransactionFilterUsecase {
  final AccountRepository accountRepository;

  TransactionFilterUsecase({required this.accountRepository});

  Future<List<Transaction>?> call(TransactionFilterParam params) async {
    List<Transaction>? transactions = await accountRepository.getAllTransactionsLocal();
    return transactions?.where((tras) {
      bool hasValidType = params.type == null;
      if (params.type == TransactionTyoe.credit && (tras.amount ?? 0) > 0) hasValidType = true;
      if (params.type == TransactionTyoe.debit && (tras.amount ?? 0) < 0) hasValidType = true;

      bool containName =
          (tras.beneficiaryName?.toLowerCase().contains((params.name ?? "").toLowerCase()) == true ||
          tras.description?.toLowerCase().contains((params.name ?? "").toLowerCase()) == true);

      return containName && hasValidType;
    }).toList();
  }
}
