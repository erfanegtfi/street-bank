import 'package:app_data/general_error.dart';
import 'package:app_data/remote/exception/network_connection_exception.dart';
import 'package:app_widgets/error_widget.dart';
import 'package:app_widgets/extentions.dart';
import 'package:app_widgets/my_scaffold.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/export_app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/presenter/transactions/providers/transaction_list_provider.dart';
import 'package:street_bank/features/dashboard/presenter/providers/get_account_balance_provider.dart';
import 'package:street_bank/features/dashboard/presenter/providers/transaction_list_provider.dart';
import 'package:street_bank/features/dashboard/presenter/widgets/dashboard_header_balance_widget.dart';
import 'package:street_bank/features/dashboard/presenter/widgets/transaction_header_widget.dart';
import 'package:street_bank/features/dashboard/presenter/widgets/transactions/transaction_list.dart';
import 'package:street_bank/navigation/routes.dart';

@RoutePage()
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late ThemeData theme;
  DashboardTransactionListNotifier? dashboardTransactionListNotifier;

  @override
  void initState() {
    dashboardTransactionListNotifier = ref.read(dashboardTransactionListProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      dashboardTransactionListNotifier?.fetchTransactions();
      ref.read(getAccountBalanceProvider.notifier).getAccountBalance();
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
    setupDashboardTransactionListProviderListeners();
    setupGetAccountBalanceProviderListeners();
    return MyScaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: getHeaderBalance()),
          SliverToBoxAdapter(child: SizedBox(height: AppDimen.spacingNormal)),
          SliverToBoxAdapter(child: TransactionListHeader()),
          SliverToBoxAdapter(child: SizedBox(height: AppDimen.spacingNormal)),
          getTransactionList(),
        ],
      ),
    );
  }

  Widget getHeaderBalance() {
    return Consumer(
      builder: (context, ref, __) {
        final result = ref.watch(getAccountBalanceProvider);
        if (result.loading == true) return SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
        if (result.balance != null) return HeaderBalance(balance: result.balance ?? 0);
        if (result.error != null) return getErrorWidget(result.error);
        return SizedBox();
      },
    );
  }

  Widget getTransactionList() {
    return Consumer(
      builder: (context, ref, __) {
        final result = ref.watch(dashboardTransactionListProvider);
        if (result.loading == true) return SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
        if (result.transactions != null) return TransactionListWidget(transactionList: result.transactions!);
        if (result.error != null) return SliverToBoxAdapter(child: getErrorWidget(result.error));
        return SliverToBoxAdapter(child: SizedBox());
      },
    );
  }

  Widget getErrorWidget(GeneralError? error) {
    if (error == null) return SizedBox();
    return MyErrorWidget(
      image: (error.appException is NetworkConnectionException) ? AppAssets.iconWifi : AppAssets.iconPaper,
      message: error.message,
    );
  }

  setupDashboardTransactionListProviderListeners() {
    ref.listen<TransactionsViewState>(dashboardTransactionListProvider, (previous, next) {
      if (next.error != null) context.showError(next.error?.message, () => locator<AppRouter>().pop());
    });
  }

  setupGetAccountBalanceProviderListeners() {
    ref.listen<AccountBalanceViewState>(getAccountBalanceProvider, (previous, next) {});
  }
}
