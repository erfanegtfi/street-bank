import 'package:app_data/general_error.dart';
import 'package:app_data/remote/exception/network_connection_exception.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:app_widgets/error_widget.dart';
import 'package:app_widgets/extentions.dart';
import 'package:app_widgets/my_scaffold.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/dashboard/presenter/providers/transaction_list_provider.dart';
import 'package:street_bank/features/dashboard/presenter/widgets/dashboard_header_balance_widget.dart';
import 'package:street_bank/features/dashboard/presenter/widgets/transactions/transaction_header_widget.dart';
import 'package:street_bank/features/dashboard/presenter/widgets/transaction_list.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late ThemeData theme;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardTransactionListProvider.notifier).subscribeOnTransactions();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    theme = context.theme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    setup_dashboardTransactionListProvider_listeners();
    return MyScaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: HeaderBalance(balance: "200")),
          SliverToBoxAdapter(child: SizedBox(height: AppDimen.spacingNormal)),
          SliverToBoxAdapter(child: TransactionListHeader()),
          SliverToBoxAdapter(child: SizedBox(height: AppDimen.spacingNormal)),
          getTransactionList(),
        ],
      ),
    );
  }

  Widget getTransactionList() {
    return Consumer(
      builder: (context, ref, __) {
        final result = ref.watch(dashboardTransactionListProvider);
        return result.maybeWhen(
          orElse: () => SliverToBoxAdapter(child: SizedBox()),
          loading: () => SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
          success: (transactions) {
            return TransactionListWidget(transactionList: transactions);
          },
          error: (error) => SliverToBoxAdapter(child: getErrorWidget(error)),
        );
      },
    );
  }

  Widget getErrorWidget(GeneralError error) {
    return MyErrorWidget(
      image: (error.appException is NetworkConnectionException) ? AppAssets.iconWifi : AppAssets.iconPaper,
      message: error.message,
    );
  }

  setup_dashboardTransactionListProvider_listeners() {
    ref.listen<ViewState<List<Transaction>>>(dashboardTransactionListProvider, (previous, next) {
      next.maybeWhen(orElse: () {}, error: (error) {});
    });
  }
}
