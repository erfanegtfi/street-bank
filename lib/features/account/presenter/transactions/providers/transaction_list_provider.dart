import 'package:app_data/remote/exception/network_connection_exception.dart';
import 'package:app_data/repository_strategy.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/usecase/params/transaction_filter_params.dart';
import 'package:street_bank/features/account/domain/usecase/params/transaction_type.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_filter_list_usecase.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_list_usecase.dart';

final transactionListProvider = StateNotifierProvider.autoDispose<TransactionListNotifier, ViewState<List<Transaction>>>((ref) {
  TransactionListUsecase transactionListUsecase = locator<TransactionListUsecase>();
  TransactionFilterUsecase transactionFilterUsecase = locator<TransactionFilterUsecase>();

  return TransactionListNotifier(transactionListUsecase, transactionFilterUsecase, ref);
});

class TransactionListNotifier extends StateNotifier<ViewState<List<Transaction>>> {
  final TransactionListUsecase transactionListUsecase;
  final TransactionFilterUsecase transactionFilterUsecase;
  final Ref ref;
  List<Transaction> transactions = [];
  final TransactionFilterParam _filter = TransactionFilterParam(transactions: []);

  TransactionListNotifier(this.transactionListUsecase, this.transactionFilterUsecase, this.ref) : super(ViewState.init());

  void subscribeOnTransactions() async {
    state = ViewState.loading();

    transactionListUsecase(RepositoryStrategy.offlineFirst, (response) {
      response.when(
        success: (transactions) {
          this.transactions = transactions ?? [];
          _applyFilter();
        },
        error: (error) {
          if (!transactions.isNotEmpty && error.appException is NetworkConnectionException) state = ViewState.error(error: error);
        },
      );
    });
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
    state = ViewState.success(await transactionFilterUsecase(_filter) ?? []);
  }
}
