import 'package:design_system/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:design_system/app_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/app/presenter/providers/my_app_provider.dart';
import 'package:street_bank/app/presenter/providers/my_app_state.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/navigation/routes.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, __) {
        MyAppState myAppState = ref.watch(myAppSettingsProvider);
        setAppBrightness(myAppState.appSettings.themeMode);

        return MaterialApp.router(
          title: AppText.appName,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: myAppState.appSettings.themeMode,
          routerConfig: locator<AppRouter>().config(),
        );
      },
    );
  }
}
