import 'package:street_bank/app/data/app_setting_storage_impl.dart';
import 'package:street_bank/app/domain/params/setting_params.dart';

class UpdateSettingUsecase {
  AppSettingStorage appSettingStorage;
  UpdateSettingUsecase(this.appSettingStorage);

  bool call(SettingParam params) {
    appSettingStorage.saveSetting(params);
    return true;
  }
}
