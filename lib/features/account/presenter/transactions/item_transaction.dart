import 'package:app_utils/utils.dart';
import 'package:app_utils/utils_date.dart';
import 'package:app_widgets/extentions.dart';
import 'package:app_widgets/my_background_widget.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    return MyBackground(
      margin: EdgeInsets.symmetric(vertical: AppDimen.spacingSmall),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text(formatPrice(transaction.amount.toString()), style: context.textTheme.titleSmall)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppText.transactionScreenBeneficiary + (transaction.beneficiaryName ?? "")),
              Text(AppText.transactionScreenDescription + (transaction.description ?? "")),
              Text(UtilsDate.formatDate(transaction.date), style: context.textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}
