import 'package:app_widgets/widget_item_not_found.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/dashboard/presenter/widgets/item_transaction.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> transactionList;
  const TransactionListWidget({required this.transactionList, super.key});

  @override
  Widget build(BuildContext context) {
    if (transactionList.isNotEmpty) {
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return TransactionHomeItem(transaction: transactionList[index]);
        }, childCount: transactionList.length),
      );
    } else {
      return SliverToBoxAdapter(child: const ItemNotFoundWidget(message: AppText.transactionScreenItemNotFound));
    }
  }
}
