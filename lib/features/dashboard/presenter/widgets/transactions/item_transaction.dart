import 'package:app_utils/utils.dart';
import 'package:app_utils/utils_date.dart';
import 'package:app_widgets/extentions.dart';
import 'package:app_widgets/my_background_widget.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';

class TransactionHomeItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionHomeItem({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    return MyBackground(
      margin: EdgeInsets.symmetric(vertical: AppDimen.spacingSmall),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(formatPriceWithTwoDecimals(transaction.amount), style: context.textTheme.titleSmall)),
          SizedBox(width: AppDimen.spacingSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transaction.description ?? ""),
              Text(UtilsDate.formatDate(transaction.date), style: context.textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}
