import 'package:injectable/injectable.dart';
import 'package:street_bank/app/data/app_setting_storage_impl.dart';
import 'package:street_bank/app/domain/repository/app_setting_storage.dart';
import 'package:street_bank/app/domain/usecase/get_setting_usecase.dart';
import 'package:street_bank/app/domain/usecase/update_setting_usecase.dart';
import 'package:street_bank/di/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bank/features/authentication/domain/usecase/is_user_login_usecase.dart';
import 'package:street_bank/navigation/routes.dart';

@module
abstract class AppSettingModule {
  @injectable
  AppSettingStorage get appLocalDataSource => AppSettingStorageImpl(locator<SharedPreferences>());

  @injectable
  UpdateSettingUsecase get updateSettingUsecase => UpdateSettingUsecase(locator<AppSettingStorage>());

  @injectable
  GetSettingUsecase get getSettingUsecase => GetSettingUsecase(locator<AppSettingStorage>());

  @lazySingleton
  @LazySingleton(order: 1)
  AppRouter get appRouter => AppRouter(locator<IsUserLoginUsecase>());
}
