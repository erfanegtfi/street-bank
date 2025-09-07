import 'package:floor/floor.dart';
import 'package:street_bank/features/account/data/model/transaction_data_model.dart';

@dao
abstract class TransactionDao {
  @Query('SELECT * FROM transactions')
  Future<List<TransactionDataModel>> getAllTransactions();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTransaction(TransactionDataModel transaction);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> updateTransaction(List<TransactionDataModel> transactions);
}
