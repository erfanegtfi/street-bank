import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/app/data/model/app_settings.dart';
import 'package:street_bank/app/domain/get_setting_usecase.dart';
import 'package:street_bank/app/domain/params/setting_params.dart';
import 'package:street_bank/app/domain/update_setting_usecase.dart';
import 'package:street_bank/di/injector.dart';

final settingProvider = NotifierProvider.autoDispose<SettingNotifier, AppSettings>(SettingNotifier.new);

class SettingNotifier extends AutoDisposeNotifier<AppSettings> {
  late final UpdateSettingUsecase _updateSettingUsecase;
  late final GetSettingUsecase _getSettingUsecase;
  AppSettings? appSettings;
  @override
  AppSettings build() {
    _updateSettingUsecase = locator<UpdateSettingUsecase>();
    _getSettingUsecase = locator<GetSettingUsecase>();
    return _getSettingUsecase();
  }

  updateBiometric(bool isBiometricAvtice) {
    appSettings = _getSettingUsecase();
    if (appSettings != null) {
      appSettings = appSettings!.copyWith(isBiometricAvtice: isBiometricAvtice);
      _updateSettingUsecase(SettingParam(isBiometricAvtice: appSettings!.isBiometricAvtice, themeMode: appSettings!.themeMode));
    }
    state = appSettings ?? AppSettings();
  }
}
