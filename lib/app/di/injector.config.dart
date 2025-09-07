// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_data/local/local_repository.dart' as _i562;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/authentication/domain/usecase/is_user_login_usecase.dart'
    as _i295;
import '../../features/authentication/domain/usecase/login_form_validation_usecase.dart'
    as _i256;
import '../../features/authentication/domain/usecase/login_user_usecase.dart'
    as _i702;
import 'injection_module.dart' as _i212;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final appModule = _$AppModule();
  await gh.lazySingletonAsync<_i460.SharedPreferences>(
    () => appModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i562.LocalRepository>(() => appModule.userRepository);
  gh.factory<_i256.LoginFormValidationUsecase>(
    () => _i256.LoginFormValidationUsecase(),
  );
  gh.factory<_i295.IsUserLoginUsecase>(
    () => _i295.IsUserLoginUsecase(gh<_i562.LocalRepository>()),
  );
  gh.factory<_i702.LoginUserUsecase>(
    () => _i702.LoginUserUsecase(gh<_i562.LocalRepository>()),
  );
  return getIt;
}

class _$AppModule extends _i212.AppModule {}
