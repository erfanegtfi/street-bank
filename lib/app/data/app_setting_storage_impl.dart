import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bank/app/data/model/app_settings.dart';
import 'package:street_bank/app/domain/params/setting_params.dart';

abstract class AppSettingStorage {
  saveSetting(SettingParam setting);
  AppSettings getSetting();
}

class AppSettingStorageImpl extends AppSettingStorage {
  final SharedPreferences prefs;
  static const String settingKey = 'settingKey';
  AppSettingStorageImpl(this.prefs);

  @override
  saveSetting(SettingParam setting) {
    prefs.setString(
      settingKey,
      jsonEncode(AppSettings().copyWith(isBiometricAvtice: setting.isBiometricAvtice, themeMode: setting.themeMode)),
    );
  }

  @override
  AppSettings getSetting() {
    String? setting = prefs.getString(settingKey);
    return setting != null ? AppSettings.fromJson(jsonDecode(setting)) : AppSettings();
  }
}
