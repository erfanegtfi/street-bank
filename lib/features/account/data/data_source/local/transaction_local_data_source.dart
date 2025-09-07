import 'package:injectable/injectable.dart';
import 'package:street_bank/database/database.dart';
import 'package:street_bank/features/account/data/model/transaction_data_model.dart';

abstract class TransactionsLocalDataSource {
  Future<List<TransactionDataModel>> getAllTransactions();
  Future<void> insertTransaction(TransactionDataModel transaction);
  Future<void> insertTransactions(List<TransactionDataModel> transactions);
}

@Injectable(as: TransactionsLocalDataSource)
class TransactionsLocalDataSourceImpl implements TransactionsLocalDataSource {
  final BankDatabase database;

  TransactionsLocalDataSourceImpl({required this.database});

  @override
  Future<List<TransactionDataModel>> getAllTransactions() {
    return database.transactionDao.getAllTransactions();
  }

  @override
  Future<void> insertTransaction(TransactionDataModel transaction) {
    return database.transactionDao.insertTransaction(transaction);
  }

  @override
  Future<void> insertTransactions(List<TransactionDataModel> transactions) {
    return database.transactionDao.updateTransaction(transactions);
  }
}
