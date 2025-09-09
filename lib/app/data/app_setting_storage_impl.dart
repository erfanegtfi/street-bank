import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bank/app/domain/entities/app_settings.dart';
import 'package:street_bank/app/domain/repository/app_setting_storage.dart';
import 'package:street_bank/app/domain/usecase/params/setting_params.dart';

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
