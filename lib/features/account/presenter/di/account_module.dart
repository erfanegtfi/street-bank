import 'package:injectable/injectable.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/data/data_source/local/transaction_local_data_source.dart';
import 'package:street_bank/features/account/data/data_source/remote/account_remote_data_source.dart';
import 'package:street_bank/features/account/data/repository/account_repository.dart';
import 'package:street_bank/features/account/domain/repositories/account_repository.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_list_usecase.dart';

@module
abstract class AccountModule {
  @LazySingleton(order: -1)
  AccountRepository get accountRepository => AccountRepositoryImpl(
    accountRemoteDataSource: locator<AccountRemoteDataSource>(),
    transactionsLocalDataSource: locator<TransactionsLocalDataSource>(),
  );

  @injectable
  TransactionListUsecase get prefs => TransactionListUsecase(accountRepository: locator<AccountRepository>());
}
