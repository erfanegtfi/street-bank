import 'package:app_widgets/buttons/text_button_widget.dart';
import 'package:app_widgets/extentions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/navigation/routes.dart';
import 'package:street_bank/navigation/routes.gr.dart';

class TransactionListHeader extends StatelessWidget {
  const TransactionListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimen.horizontalSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppText.homeScreenTransactionsList, style: context.textTheme.titleMedium),
          MyTextButton(AppText.homeScreenTransactionsSeeAll, () {
            context.router.push(TransactionListRoute());
          }),
        ],
      ),
    );
  }
}
