import 'package:street_bank/app/domain/entities/app_settings.dart';
import 'package:street_bank/app/domain/repository/app_setting_storage.dart';

class GetSettingUsecase {
  AppSettingStorage appSettingStorage;
  GetSettingUsecase(this.appSettingStorage);

  AppSettings call() {
    return appSettingStorage.getSetting();
  }
}
