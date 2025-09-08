import 'package:app_data/model/data_response.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';

abstract class AccountRepository {
  Future<List<Transaction>?> getAllTransactionsLocal();

  Future<DataResponse<List<Transaction>?>> getAllTransactionsRemote();
  double? getUserBalance();
  setUserBalance(double balance);
}
