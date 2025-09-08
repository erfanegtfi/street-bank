import 'package:injectable/injectable.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/data/data_source/local/account_local_storage_impl.dart';
import 'package:street_bank/features/account/data/data_source/local/transaction_local_data_source.dart';
import 'package:street_bank/features/account/data/data_source/remote/account_remote_data_source.dart';
import 'package:street_bank/features/account/data/repository/account_repository.dart';
import 'package:street_bank/features/account/domain/repositories/account_repository.dart';
import 'package:street_bank/features/account/domain/usecase/get_account_balance_usecase.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_filter_list_usecase.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_list_usecase.dart';

@module
abstract class AccountModule {
  @LazySingleton(order: -1)
  AccountRepository get accountRepository => AccountRepositoryImpl(
    accountRemoteDataSource: locator<AccountRemoteDataSource>(),
    transactionsLocalDataSource: locator<TransactionsLocalDataSource>(),
    accountLocalStorage: locator<AccountLocalStorage>(),
  );

  @injectable
  TransactionListUsecase get transactionListUsecase => TransactionListUsecase(accountRepository: locator<AccountRepository>());
  @injectable
  GetAccountBalanceUsecase get getAccountBalanceUsecase => GetAccountBalanceUsecase(accountRepository: locator<AccountRepository>());
  @injectable
  TransactionFilterUsecase get transactionFilterUsecase => TransactionFilterUsecase(accountRepository: locator<AccountRepository>());
}
