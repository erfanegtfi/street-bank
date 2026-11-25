import 'package:app_data/model/data_response.dart';
import 'package:app_utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_list_stream_usecase.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_list_usecase.dart';
import 'package:street_bank/features/account/presenter/transactions/providers/transaction_list_provider.dart';

final dashboardTransactionListProvider = StateNotifierProvider.autoDispose<DashboardTransactionListNotifier, TransactionsViewState>((ref) {
  TransactionListUsecase transactionListUsecase = locator<TransactionListUsecase>();
  TransactionListStreamUsecase transactionListStreamUsecase = locator<TransactionListStreamUsecase>();

  return DashboardTransactionListNotifier(transactionListUsecase, transactionListStreamUsecase, ref);
});

class DashboardTransactionListNotifier extends StateNotifier<TransactionsViewState> {
  final TransactionListUsecase transactionListUsecase;
  final TransactionListStreamUsecase transactionListStreamUsecase;
  List<Transaction> transactions = [];
  final Ref ref;

  DashboardTransactionListNotifier(this.transactionListUsecase, this.transactionListStreamUsecase, this.ref)
    : super(TransactionsViewState.init()) {
    transactionListStreamUsecase.call().listen((transactions) {
      this.transactions = transactions ?? [];
      emitState(transactions);
    });
  }

  void fetchTransactions() async {
    state = state.copyWith(loading: true);

    DataResponse<List<Transaction>?> response = await transactionListUsecase();
    if (!mounted) return;
    response.when(
      success: (transactions) {
        this.transactions = transactions ?? [];
        emitState(transactions);
      },
      error: (error) {
        state = state.copyWith(loading: false, error: error);
      },
    );
  }

  void emitState(List<Transaction>? transactions) {
    if ((transactions?.length ?? 0) >= Constants.homeTrasactionListCount)
      state = TransactionsViewState.success(transactions?.sublist(0, Constants.homeTrasactionListCount));
    else
      state = TransactionsViewState.success(transactions);
  }
}
