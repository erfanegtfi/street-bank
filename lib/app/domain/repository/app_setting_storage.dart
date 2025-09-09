import 'package:street_bank/app/domain/entities/app_settings.dart';
import 'package:street_bank/app/domain/usecase/params/setting_params.dart';

abstract class AppSettingStorage {
  saveSetting(SettingParam setting);
  AppSettings getSetting();
}
