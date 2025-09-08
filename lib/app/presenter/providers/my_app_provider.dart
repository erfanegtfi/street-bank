import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/app/data/model/app_settings.dart';
import 'package:street_bank/app/domain/get_setting_usecase.dart';
import 'package:street_bank/app/domain/params/setting_params.dart';
import 'package:street_bank/app/domain/update_setting_usecase.dart';
import 'package:street_bank/app/presenter/providers/my_app_state.dart';
import 'package:street_bank/di/injector.dart';

/// handle app theme
final myAppSettingsProvider = StateNotifierProvider.autoDispose<MyAppSettingsNotifier, MyAppState>((ref) {
  var getSettingUsecase = locator<GetSettingUsecase>();
  var updateSettingUsecase = locator<UpdateSettingUsecase>();

  return MyAppSettingsNotifier(ref, updateSettingUsecase, getSettingUsecase);
});

class MyAppSettingsNotifier extends StateNotifier<MyAppState> {
  final Ref ref;
  GetSettingUsecase getSettingUsecase;
  UpdateSettingUsecase updateSettingUsecase;

  MyAppSettingsNotifier(this.ref, this.updateSettingUsecase, this.getSettingUsecase)
    : super(InitialState(appSettings: getSettingUsecase()));

  Future<void> toggleTheme() async {
    AppSettings setting = getSettingUsecase();
    setting = setting.copyWith(themeMode: setting.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
    state = AppStateChangedState(appSettings: setting);

    updateSettingUsecase(SettingParam(isBiometricAvtice: setting.isBiometricAvtice, themeMode: setting.themeMode));
  }
}
