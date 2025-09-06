import 'package:design_system/colors/colors.dart';
import 'package:design_system/colors/dark_colors.dart';
import 'package:design_system/colors/light_colors.dart';
import 'package:design_system/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Brightness appBrightness = Brightness.light;

const lightColors = LightColors();
const darkColors = DarkColors();

setAppBrightness(ThemeMode appThemeMode) {
  if (appThemeMode == ThemeMode.dark)
    appBrightness = Brightness.dark;
  else if (appThemeMode == ThemeMode.light)
    appBrightness = Brightness.light;
  else // ThemeMode.system
    appBrightness = MediaQueryData.fromView(WidgetsBinding.instance.window).platformBrightness;
}

MyColors appColors() {
  return isAppThemeLight() ? LightColors() : DarkColors();
}

bool isAppThemeLight() {
  return appBrightness == Brightness.light;
}

final ThemeData lightTheme = ThemeData(
  primaryColor: lightColors.primary,
  colorScheme: ColorScheme.light(
    primary: lightColors.primary,
    primaryContainer: lightColors.primary,
    onPrimary: lightColors.white,
    secondary: lightColors.secondery,
    secondaryContainer: lightColors.secondery,
    surface: lightColors.screenBackground,
    error: lightColors.error,
    onError: lightColors.white,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: lightColors.screenBackground,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(backgroundColor: lightColors.appbarBackground, systemOverlayStyle: SystemUiOverlayStyle.dark),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: lightColors.primary),
  ),

  textTheme: TextTheme(
    displayLarge: textDisplayLarge.copyWith(color: lightColors.textBlack),
    displayMedium: textDisplayMedium.copyWith(color: lightColors.textBlack),
    displaySmall: textDisplaySmall.copyWith(color: lightColors.textBlack),
    headlineLarge: textHeadLinelarge.copyWith(color: lightColors.textBlack),
    headlineMedium: textHeadLineMedium.copyWith(color: lightColors.textBlack),
    headlineSmall: textHeadLineSmall.copyWith(color: lightColors.textBlack),
    titleLarge: textTitlelarge.copyWith(color: lightColors.textBlack),
    titleMedium: textTitleMedium.copyWith(color: lightColors.textBlack),
    titleSmall: textTitleSmall.copyWith(color: lightColors.textBlack),
    bodyLarge: textBodylarge.copyWith(color: lightColors.textBlack),
    bodyMedium: textBodyMedium.copyWith(color: lightColors.textBlack),
    bodySmall: textBodySmall.copyWith(color: lightColors.textBlack),
    labelLarge: textLablelarge.copyWith(color: lightColors.textGrey),
    labelMedium: textLableMedium.copyWith(color: lightColors.textGrey),
    labelSmall: textLableSmall.copyWith(color: lightColors.textGrey),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: darkColors.primary,
  colorScheme: ColorScheme.dark(
    primary: darkColors.primary,
    primaryContainer: darkColors.primary,
    onPrimary: darkColors.white,
    secondary: darkColors.secondery,
    secondaryContainer: darkColors.secondery,
    surface: darkColors.screenBackground,
    error: darkColors.error,
    onError: darkColors.white,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: darkColors.screenBackground,
  appBarTheme: AppBarTheme(backgroundColor: darkColors.appbarBackground, systemOverlayStyle: SystemUiOverlayStyle.light),
  brightness: Brightness.dark,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: darkColors.primary),
  ),

  textTheme: TextTheme(
    displayLarge: textDisplayLarge.copyWith(color: darkColors.textBlack),
    displayMedium: textDisplayMedium.copyWith(color: darkColors.textBlack),
    displaySmall: textDisplaySmall.copyWith(color: darkColors.textBlack),
    headlineLarge: textHeadLinelarge.copyWith(color: darkColors.textBlack),
    headlineMedium: textHeadLineMedium.copyWith(color: darkColors.textBlack),
    headlineSmall: textHeadLineSmall.copyWith(color: darkColors.textBlack),
    titleLarge: textTitlelarge.copyWith(color: darkColors.textBlack),
    titleMedium: textTitleMedium.copyWith(color: darkColors.textBlack),
    titleSmall: textTitleSmall.copyWith(color: darkColors.textBlack),
    bodyLarge: textBodylarge.copyWith(color: darkColors.textBlack),
    bodyMedium: textBodyMedium.copyWith(color: darkColors.textBlack),
    bodySmall: textBodySmall.copyWith(color: darkColors.textBlack),
    labelLarge: textLablelarge.copyWith(color: darkColors.textGrey),
    labelMedium: textLableMedium.copyWith(color: darkColors.textGrey),
    labelSmall: textLableSmall.copyWith(color: darkColors.textGrey),
  ),
);
