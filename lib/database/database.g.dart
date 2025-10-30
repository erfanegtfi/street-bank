// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FroomGenerator
// **************************************************************************

abstract class $BankDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $BankDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $BankDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<BankDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FroomBankDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $BankDatabaseBuilderContract databaseBuilder(String name) =>
      _$BankDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $BankDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$BankDatabaseBuilder(null);
}

class _$BankDatabaseBuilder implements $BankDatabaseBuilderContract {
  _$BankDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $BankDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $BankDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<BankDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$BankDatabase();
    database.database = await database.open(path, _migrations, _callback);
    return database;
  }
}

class _$BankDatabase extends BankDatabase {
  _$BankDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TransactionDao? _transactionDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
          database,
          startVersion,
          endVersion,
          migrations,
        );

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `transactions` (`id` TEXT, `date` TEXT, `description` TEXT, `amount` REAL, `beneficiary_name` TEXT, `account_number` TEXT, PRIMARY KEY (`id`))',
        );

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TransactionDao get transactionDao {
    return _transactionDaoInstance ??= _$TransactionDao(
      database,
      changeListener,
    );
  }
}

class _$TransactionDao extends TransactionDao {
  _$TransactionDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _transactionDataModelInsertionAdapter = InsertionAdapter(
        database,
        'transactions',
        (TransactionDataModel item) => <String, Object?>{
          'id': item.id,
          'date': item.date,
          'description': item.description,
          'amount': item.amount,
          'beneficiary_name': item.beneficiaryName,
          'account_number': item.accountNumber,
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TransactionDataModel>
  _transactionDataModelInsertionAdapter;

  @override
  Future<List<TransactionDataModel>> getAllTransactions() async {
    return _queryAdapter.queryList(
      'SELECT * FROM transactions  ORDER BY date DESC',
      mapper: (Map<String, Object?> row) => TransactionDataModel(
        id: row['id'] as String?,
        date: row['date'] as String?,
        description: row['description'] as String?,
        amount: row['amount'] as double?,
        beneficiaryName: row['beneficiary_name'] as String?,
        accountNumber: row['account_number'] as String?,
      ),
    );
  }

  @override
  Future<void> insertTransaction(TransactionDataModel transaction) async {
    await _transactionDataModelInsertionAdapter.insert(
      transaction,
      OnConflictStrategy.replace,
    );
  }

  @override
  Future<void> insertTransactions(
    List<TransactionDataModel> transactions,
  ) async {
    await _transactionDataModelInsertionAdapter.insertList(
      transactions,
      OnConflictStrategy.replace,
    );
  }
}
