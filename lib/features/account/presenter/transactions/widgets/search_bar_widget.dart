import 'package:app_widgets/input_text_field.dart';
import 'package:design_system/app_dimen.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:street_bank/features/account/domain/usecase/params/transaction_type.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String text) onTextChanged;
  final Function(TransactionTyoe transactionType) onFilter;
  const SearchBarWidget({required this.onTextChanged, required this.onFilter, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppDimen.horizontalSpacing),
        Flexible(
          child: MyInputTextField(
            hint: AppText.transactionScreenSearch,
            onTextChanged: (value) {
              onTextChanged(value);
            },
          ),
        ),
        PopupMenuButton<TransactionTyoe>(
          icon: Icon(Icons.filter_alt_rounded),
          onSelected: (value) {
            onFilter(value);
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(value: TransactionTyoe.all, child: Text(AppText.transactionScreenAll)),
              const PopupMenuItem(value: TransactionTyoe.debit, child: Text(AppText.transactionScreenDebit)),
              const PopupMenuItem(value: TransactionTyoe.credit, child: Text(AppText.transactionScreenCredit)),
            ];
          },
        ),
      ],
    );
  }
}
