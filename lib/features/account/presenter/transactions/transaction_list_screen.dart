import 'package:app_data/remote/exception/network_connection_exception.dart';
import 'package:app_widgets/error_widget.dart';
import 'package:app_widgets/my_scaffold.dart';
import 'package:app_widgets/widget_item_not_found.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/features/account/presenter/transactions/item_transaction.dart';
import 'package:street_bank/features/account/presenter/transactions/providers/transaction_list_provider.dart';
import 'package:street_bank/features/account/presenter/transactions/widgets/search_bar_widget.dart';

@RoutePage()
class TransactionListScreen extends ConsumerStatefulWidget {
  const TransactionListScreen({super.key});

  @override
  ConsumerState<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends ConsumerState<TransactionListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transactionListProvider.notifier).subscribeOnTransactions();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setup_transactionListProvider_listeners();
    return MyScaffold(
      body: getBody(),
      appBar: AppBar(title: Text(AppText.transactionScreenTitle)),
    );
  }

  Widget getBody() {
    return Column(
      children: [
        SizedBox(height: AppDimen.spacingNormal),
        SearchBarWidget(
          onTextChanged: (text) {
            ref.watch(transactionListProvider.notifier).search(text);
          },
          onFilter: (transactionType) {
            ref.watch(transactionListProvider.notifier).changeType(transactionType);
          },
        ),
        SizedBox(height: AppDimen.spacingNormal),
        Expanded(
          child: Consumer(
            builder: (context, ref, __) {
              final result = ref.watch(transactionListProvider);
              if (result.transactions?.isNotEmpty == true) {
                return ListView.builder(
                  itemBuilder: (context, index) => TransactionItem(transaction: result.transactions![index]),
                  itemCount: result.transactions?.length ?? 0,
                );
              } else if (result.error == null && result.loading != true) {
                return SizedBox(height: 200, child: const ItemNotFoundWidget(message: AppText.transactionScreenItemNotFound));
              } else if (result.error != null) {
                return SizedBox(
                  height: 200,
                  child: MyErrorWidget(
                    image: (result.error?.appException is NetworkConnectionException) ? AppAssets.iconWifi : AppAssets.iconPaper,
                    message: result.error?.message,
                  ),
                );
              } else if (result.loading == true) {
                return Center(child: CircularProgressIndicator());
              }
              return SizedBox();
            },
          ),
        ),
      ],
    );
  }

  setup_transactionListProvider_listeners() {
    ref.listen<TransactionsViewState>(transactionListProvider, (previous, next) {});
  }
}
