import 'package:street_bank/app/domain/repository/app_setting_storage.dart';
import 'package:street_bank/app/domain/usecase/params/setting_params.dart';

class UpdateSettingUsecase {
  AppSettingStorage appSettingStorage;
  UpdateSettingUsecase(this.appSettingStorage);

  bool call(SettingParam params) {
    appSettingStorage.saveSetting(params);
    return true;
  }
}
