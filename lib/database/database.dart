import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:froom/froom.dart';
import 'package:street_bank/features/account/data/data_source/local/transactions_dao.dart';
import 'package:street_bank/features/account/data/model/transaction_data_model.dart';

part 'database.g.dart';

@Database(version: 1, entities: [TransactionDataModel])
abstract class BankDatabase extends FroomDatabase {
  TransactionDao get transactionDao;
}
