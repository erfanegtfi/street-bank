import 'package:app_data/repository_strategy.dart';
import 'package:app_utils/constants.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_list_usecase.dart';

final dashboardTransactionListProvider = StateNotifierProvider.autoDispose<DashboardTransactionListNotifier, ViewState<List<Transaction>>>((
  ref,
) {
  TransactionListUsecase transactionListUsecase = locator<TransactionListUsecase>();

  return DashboardTransactionListNotifier(transactionListUsecase, ref);
});

class DashboardTransactionListNotifier extends StateNotifier<ViewState<List<Transaction>>> {
  final TransactionListUsecase transactionListUsecase;

  List<Transaction> transactions = [];
  final Ref ref;

  DashboardTransactionListNotifier(this.transactionListUsecase, this.ref) : super(ViewState.init());

  void fetchTransactions() async {
    state = ViewState.loading();
    transactionListUsecase(RepositoryStrategy.offlineFirst, (response) {
      response.when(
        success: (transactions) {
          this.transactions = transactions ?? [];
          if ((transactions?.length ?? 0) >= Constants.homeTrasactionListCount)
            state = ViewState.success(transactions!.sublist(0, Constants.homeTrasactionListCount));
          else
            state = ViewState.success(transactions ?? []);
        },
        error: (error) {
          state = ViewState.error(error: error);
        },
      );
    });
  }

  List<Transaction> getAllTransactions() => transactions;
}

final dashboardTransactionListUIProvider = Provider.autoDispose<ViewState<List<Transaction>>>((ref) {
  final value = ref.watch(dashboardTransactionListProvider);
  return value.maybeWhen(
    orElse: () => value,
    error: (error, formError) {
      List<Transaction> lastSuccessvalue = ref.read(dashboardTransactionListProvider.notifier).getAllTransactions();
      if (lastSuccessvalue.isNotEmpty == true) return ViewState.success(lastSuccessvalue);
      return ViewState.error(error: error);
    },
  );
});
