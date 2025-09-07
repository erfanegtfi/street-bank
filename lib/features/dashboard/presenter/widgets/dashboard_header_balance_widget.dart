import 'package:flutter/material.dart';
import 'package:app_widgets/extentions.dart';
import 'package:app_widgets/my_background_widget.dart';
import 'package:design_system/export_app_res.dart';
import 'package:street_bank/features/dashboard/presenter/widgets/dashboard_button_widget.dart';

class HeaderBalance extends StatelessWidget {
  final String balance;
  const HeaderBalance({required this.balance, super.key});

  @override
  Widget build(BuildContext context) {
    late ThemeData theme = context.theme;

    return MyBackground(
      height: 280,
      radius: 0,
      width: double.infinity,
      colorBack: Color(0xff456aef),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Column(
            children: [
              Text(AppText.homeScreenBalance, style: theme.textTheme.headlineLarge?.copyWith(color: appColors().white)),
              Text(balance, style: theme.textTheme.headlineLarge?.copyWith(color: appColors().white)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HeaderButton(title: AppText.homeScreenTransactions, icon: Icons.list_alt_rounded, onPressed: () {}),
              HeaderButton(title: AppText.homeScreenTransfer, icon: Icons.monetization_on, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
