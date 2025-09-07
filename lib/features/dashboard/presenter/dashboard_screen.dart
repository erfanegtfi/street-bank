import 'package:app_widgets/buttons/text_button_widget.dart';
import 'package:app_widgets/extentions.dart';
import 'package:app_widgets/my_scaffold.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:street_bank/features/dashboard/presenter/widgets/dashboard_header_balance_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ThemeData theme;
  @override
  void didChangeDependencies() {
    theme = context.theme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            HeaderBalance(balance: "200"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppText.homeScreenTransactionsList, style: theme.textTheme.titleMedium),
                  MyTextButton(AppText.homeScreenTransactionsSeeAll, () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
