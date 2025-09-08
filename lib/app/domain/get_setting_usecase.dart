import 'package:street_bank/app/data/app_setting_storage_impl.dart';
import 'package:street_bank/app/data/model/app_settings.dart';

class GetSettingUsecase {
  AppSettingStorage appSettingStorage;
  GetSettingUsecase(this.appSettingStorage);

  AppSettings call() {
    return appSettingStorage.getSetting();
  }
}
