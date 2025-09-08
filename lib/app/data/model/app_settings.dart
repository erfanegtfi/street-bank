import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.g.dart';

@JsonSerializable()
class AppSettings {
  final ThemeMode themeMode;
  final bool isBiometricAvtice;

  const AppSettings({this.themeMode = ThemeMode.system, this.isBiometricAvtice = false});

  AppSettings copyWith({ThemeMode? themeMode, bool? isBiometricAvtice}) {
    return AppSettings(themeMode: themeMode ?? this.themeMode, isBiometricAvtice: isBiometricAvtice ?? this.isBiometricAvtice);
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) => _$AppSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);
}
