import 'package:app_widgets/extentions.dart';
import 'package:app_widgets/my_scaffold.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/app/presenter/providers/my_app_provider.dart';
import 'package:street_bank/features/settings/settings_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late ThemeData theme;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    super.initState();
  }

  @override
  void didChangeDependencies() {
    theme = context.theme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(title: Text(AppText.settingScreenTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppDimen.spacingNormal),
        child: Column(
          children: [
            Row(
              children: [
                Switch(
                  onChanged: (value) {
                    ref.read(myAppSettingsProvider.notifier).toggleTheme();
                  },
                  value: isAppThemeLight(),
                ),
                Text(
                  "${AppText.settingScreenToggleThemeSwitch} ${isAppThemeLight() ? AppText.settingScreenThemeDark : AppText.settingScreenThemeLight}",
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),

            Consumer(
              builder: (context, ref, __) {
                final result = ref.watch(settingProvider);
                return Row(
                  children: [
                    Switch(
                      onChanged: (value) {
                        ref.read(settingProvider.notifier).updateBiometric(!result.isBiometricAvtice);
                      },
                      value: result.isBiometricAvtice,
                    ),
                    Text(AppText.settingScreenToggleBiometric, style: theme.textTheme.bodyMedium),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
