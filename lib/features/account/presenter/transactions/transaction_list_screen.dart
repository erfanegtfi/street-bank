import 'package:app_data/remote/exception/network_connection_exception.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:app_widgets/error_widget.dart';
import 'package:app_widgets/my_scaffold.dart';
import 'package:app_widgets/widget_item_not_found.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
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
              return result.maybeWhen(
                orElse: () => SizedBox(),
                loading: () => Center(child: CircularProgressIndicator()),
                success: (transactions) {
                  if (transactions.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) => TransactionItem(transaction: transactions[index]),
                      itemCount: transactions.length,
                    );
                  } else {
                    return SizedBox(height: 200, child: const ItemNotFoundWidget(message: AppText.transactionScreenItemNotFound));
                  }
                },
                error: (error, formError) => error != null
                    ? SizedBox(
                        height: 200,
                        child: MyErrorWidget(
                          image: (error.appException is NetworkConnectionException) ? AppAssets.iconWifi : AppAssets.iconPaper,
                          message: error.message,
                        ),
                      )
                    : SizedBox(),
              );
            },
          ),
        ),
      ],
    );
  }

  setup_transactionListProvider_listeners() {
    ref.listen<ViewState<List<Transaction>>>(transactionListProvider, (previous, next) {
      next.maybeWhen(orElse: () {}, error: (error, formError) {});
    });
  }
}
