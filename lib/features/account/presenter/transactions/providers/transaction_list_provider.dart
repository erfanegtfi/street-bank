import 'package:app_data/general_error.dart';
import 'package:app_data/model/data_response.dart';
import 'package:app_data/repository_strategy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/usecase/params/transaction_filter_params.dart';
import 'package:street_bank/features/account/domain/usecase/params/transaction_type.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_filter_list_usecase.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_list_stream_usecase.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_list_usecase.dart';

final transactionListProvider = StateNotifierProvider.autoDispose<TransactionListNotifier, TransactionsViewState>((ref) {
  TransactionListUsecase transactionListUsecase = locator<TransactionListUsecase>();
  TransactionFilterUsecase transactionFilterUsecase = locator<TransactionFilterUsecase>();
  TransactionListStreamUsecase transactionListStreamUsecase = locator<TransactionListStreamUsecase>();

  return TransactionListNotifier(transactionListUsecase, transactionFilterUsecase, transactionListStreamUsecase, ref);
});

class TransactionListNotifier extends StateNotifier<TransactionsViewState> {
  final TransactionListUsecase transactionListUsecase;
  final TransactionListStreamUsecase transactionListStreamUsecase;
  final TransactionFilterUsecase transactionFilterUsecase;
  final Ref ref;
  List<Transaction> transactions = [];
  final TransactionFilterParam _filter = TransactionFilterParam(transactions: []);

  TransactionListNotifier(this.transactionListUsecase, this.transactionFilterUsecase, this.transactionListStreamUsecase, this.ref)
    : super(TransactionsViewState.init()) {
    transactionListStreamUsecase.call().listen((transactions) {
      this.transactions = transactions ?? [];
      _applyFilter();
    });
  }

  void subscribeOnTransactions() async {
    state = state.copyWith(loading: true);

    DataResponse<List<Transaction>?> response = await transactionListUsecase();
    if (!mounted) return;
    response.when(
      success: (transactions) {
        this.transactions = transactions ?? [];
        _applyFilter();
      },
      error: (error) {
        state = state.copyWith(loading: false, error: error);
        // if (!transactions.isNotEmpty && error.appException is NetworkConnectionException) state = ViewState.error(error: error);
      },
    );
  }

  void search(String query) {
    _filter.name = query;

    _applyFilter();
  }

  void changeType(TransactionTyoe? type) {
    _filter.type = type;

    _applyFilter();
  }

  _applyFilter() async {
    _filter.transactions = transactions;
    state = TransactionsViewState.success(await transactionFilterUsecase(_filter) ?? []);
  }
}

class TransactionsViewState {
  GeneralError? error;
  List<Transaction>? transactions;
  bool? loading;

  TransactionsViewState.init();
  TransactionsViewState.loading() : loading = true;
  TransactionsViewState.serverError(this.error) : loading = false;
  TransactionsViewState.success(this.transactions);

  TransactionsViewState({this.error, this.transactions, this.loading});

  TransactionsViewState copyWith({GeneralError? error, List<Transaction>? transactions, bool? loading}) {
    return TransactionsViewState(
      error: error ?? this.error,
      transactions: transactions ?? this.transactions,
      loading: loading ?? this.loading,
    );
  }
}
