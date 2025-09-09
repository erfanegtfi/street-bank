import 'dart:async';

import 'package:app_data/model/data_response.dart';
import 'package:app_data/remote/exception/network_connection_exception.dart';
import 'package:app_data/repository_strategy.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/usecase/params/transaction_filter_params.dart';
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
  StreamSubscription<DataResponse<List<Transaction>?>>? _subscription;
  final Ref ref;
  List<Transaction> transactions = [];

  TransactionListNotifier(this.transactionListUsecase, this.transactionFilterUsecase, this.ref) : super(ViewState.init());

  void subscribeOnTransactions() async {
    state = ViewState.loading();
    await _subscription?.cancel();
    _subscription = transactionListUsecase(RepositoryStrategy.offlineFirst).listen((result) {
      result.when(
        success: (transactions) {
          this.transactions = transactions ?? [];
          state = ViewState.success(transactions ?? []);
        },
        error: (error) {
          if (!transactions.isNotEmpty && error.appException is NetworkConnectionException) state = ViewState.error(error);
        },
      );
    });
  }

  filterList(TransactionFilterParam params) async {
    state = ViewState.success(await transactionFilterUsecase(params) ?? []);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
