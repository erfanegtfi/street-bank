import 'package:app_data/remote/exception/network_connection_exception.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:app_widgets/error_widget.dart';
import 'package:app_widgets/my_scaffold.dart';
import 'package:app_widgets/widget_item_not_found.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/features/account/presenter/transactions/transaction_list_provider.dart';

class TransactionListScreen extends ConsumerStatefulWidget {
  const TransactionListScreen({super.key});

  @override
  ConsumerState<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends ConsumerState<TransactionListScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(body: getBody());
  }

  Widget getBody() {
    return Consumer(
      builder: (context, ref, __) {
        final result = ref.watch(transactionListProvider);
        return result.maybeWhen(
          orElse: () => SizedBox(),
          loading: () => Center(child: CircularProgressIndicator()),
          success: (transactions) {
            if (transactions.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(title: Text(transactions[index].description ?? "")),
                itemCount: transactions.length,
              );
            } else {
              return SizedBox(height: 200, child: const ItemNotFoundWidget(message: AppText.transactionScreenItemNotFound));
            }
          },
          error: (error) => SizedBox(
            height: 200,
            child: MyErrorWidget(
              image: (error.appException is NetworkConnectionException) ? AppAssets.iconWifi : AppAssets.iconPaper,
              message: error.message,
            ),
          ),
        );
      },
    );
  }
}
