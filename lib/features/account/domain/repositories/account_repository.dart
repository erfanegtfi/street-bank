import 'package:app_data/model/data_response.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/usecase/params/transfer_balance_params.dart';

abstract class AccountRepository {
  Future<List<Transaction>?> getAllTransactionsLocal();
  Future<DataResponse<List<Transaction>?>> getAllTransactionsRemote();

  Future<bool> addTransaction(TransferBalanceParams transaction);

  double? getUserBalance();
  setUserBalance(double balance);
}
