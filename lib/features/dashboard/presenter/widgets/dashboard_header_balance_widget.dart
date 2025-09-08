import 'package:app_utils/constants.dart';
import 'package:app_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:app_widgets/extentions.dart';
import 'package:app_widgets/my_background_widget.dart';
import 'package:design_system/export_app_res.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/presenter/transactions/transaction_list_screen.dart';
import 'package:street_bank/features/account/presenter/transfer/transfer_screen.dart';
import 'package:street_bank/features/dashboard/presenter/widgets/dashboard_button_widget.dart';
import 'package:street_bank/features/settings/settings_screen.dart';
import 'package:street_bank/navigation/navigation_service.dart';

class HeaderBalance extends StatelessWidget {
  final double balance;
  const HeaderBalance({required this.balance, super.key});

  @override
  Widget build(BuildContext context) {
    late ThemeData theme = context.theme;

    return MyBackground(
      height: 280,
      radius: 0,
      width: double.infinity,
      colorBack: Color(0xff456aef),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [getSettingButton(), getBalance(theme), getButtons()]),
    );
  }

  Widget getSettingButton() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppDimen.spacingLarge),
          child: IconButton(
            onPressed: () {
              locator<NavigationService>().push(SettingsScreen());
            },
            icon: Icon(Icons.settings, color: appColors().white),
          ),
        ),
      ],
    );
  }

  Widget getBalance(ThemeData theme) {
    return Column(
      children: [
        Text(AppText.homeScreenBalance, style: theme.textTheme.headlineLarge?.copyWith(color: appColors().white)),
        Text(
          formatPrice(balance.toString()) + Constants.currency,
          style: theme.textTheme.headlineLarge?.copyWith(color: appColors().white),
        ),
      ],
    );
  }

  Widget getButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HeaderButton(
          title: AppText.homeScreenTransactions,
          icon: Icons.list_alt_rounded,
          onPressed: () {
            locator<NavigationService>().push(TransactionListScreen());
          },
        ),
        HeaderButton(
          title: AppText.homeScreenTransfer,
          icon: Icons.monetization_on,
          onPressed: () {
            locator<NavigationService>().push(TransferScreen());
          },
        ),
      ],
    );
  }
}
