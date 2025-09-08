// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_data/local/local_storage.dart' as _i377;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../app/data/app_setting_storage_impl.dart' as _i301;
import '../app/domain/get_setting_usecase.dart' as _i3;
import '../app/domain/update_setting_usecase.dart' as _i896;
import '../app/presenter/di/app_setting_module.dart' as _i238;
import '../database/database.dart' as _i660;
import '../features/account/data/data_source/local/account_local_storage_impl.dart'
    as _i416;
import '../features/account/data/data_source/local/transaction_local_data_source.dart'
    as _i482;
import '../features/account/data/data_source/remote/account_remote_data_source.dart'
    as _i265;
import '../features/account/data/data_source/remote/account_rest_client.dart'
    as _i257;
import '../features/account/domain/repositories/account_repository.dart'
    as _i457;
import '../features/account/domain/usecase/get_account_balance_usecase.dart'
    as _i241;
import '../features/account/domain/usecase/transaction_filter_list_usecase.dart'
    as _i916;
import '../features/account/domain/usecase/transaction_list_usecase.dart'
    as _i24;
import '../features/account/domain/usecase/transfer_balance_usecase.dart'
    as _i1056;
import '../features/account/domain/usecase/transfer_form_validation_usecase.dart'
    as _i867;
import '../features/account/presenter/di/account_module.dart' as _i637;
import '../features/authentication/domain/usecase/is_user_login_usecase.dart'
    as _i701;
import '../features/authentication/domain/usecase/login_form_validation_usecase.dart'
    as _i1062;
import '../features/authentication/domain/usecase/login_user_usecase.dart'
    as _i364;
import '../features/authentication/presenter/di/auth_module.dart' as _i733;
import '../navigation/navigation_service.dart' as _i17;
import 'injection_module.dart' as _i212;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  final accountModule = _$AccountModule();
  final authModule = _$AuthModule();
  final appSettingModule = _$AppSettingModule();
  gh.lazySingleton<_i361.Dio>(() => appModule.dio);
  await gh.lazySingletonAsync<_i660.BankDatabase>(
    () => appModule.initDatabase(),
    preResolve: true,
  );
  gh.lazySingleton<String>(
    () => appModule.basetUrl,
    instanceName: 'baseUrl',
  );
  await gh.lazySingletonAsync<_i460.SharedPreferences>(
    () => appModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i377.LocalStorage>(() => appModule.userRepository);
  gh.lazySingleton<_i457.AccountRepository>(
      () => accountModule.accountRepository);
  gh.factory<_i24.TransactionListUsecase>(
      () => accountModule.transactionListUsecase);
  gh.factory<_i241.GetAccountBalanceUsecase>(
      () => accountModule.getAccountBalanceUsecase);
  gh.factory<_i916.TransactionFilterUsecase>(
      () => accountModule.transactionFilterUsecase);
  gh.factory<_i1056.TransferBalanceUsecase>(
      () => accountModule.transferBalanceUsecase);
  gh.factory<_i867.TransferFormValidationUsecase>(
      () => accountModule.transferFormValidationUsecase);
  gh.factory<_i364.LoginUserUsecase>(() => authModule.loginUserUsecase);
  gh.factory<_i1062.LoginFormValidationUsecase>(
      () => authModule.loginFormValidationUsecase);
  gh.factory<_i701.IsUserLoginUsecase>(() => authModule.isUserLoginUsecase);
  gh.factory<_i301.AppSettingStorage>(
      () => appSettingModule.appLocalDataSource);
  gh.factory<_i896.UpdateSettingUsecase>(
      () => appSettingModule.updateSettingUsecase);
  gh.factory<_i3.GetSettingUsecase>(() => appSettingModule.getSettingUsecase);
  gh.lazySingleton<_i17.NavigationService>(() => appModule.navigationService);
  gh.factory<_i482.TransactionsLocalDataSource>(() =>
      _i482.TransactionsLocalDataSourceImpl(
          database: gh<_i660.BankDatabase>()));
  gh.factory<_i416.AccountLocalStorage>(
      () => _i416.AccountLocalStorageImpl(gh<_i460.SharedPreferences>()));
  gh.factory<_i257.AccountRestClient>(() => _i257.AccountRestClient(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
      ));
  gh.factory<_i265.AccountRemoteDataSource>(() =>
      _i265.AccountRemoteDataSourceImpl(
          restClient: gh<_i257.AccountRestClient>()));
  return getIt;
}

class _$AppModule extends _i212.AppModule {}

class _$AccountModule extends _i637.AccountModule {}

class _$AuthModule extends _i733.AuthModule {}

class _$AppSettingModule extends _i238.AppSettingModule {}
