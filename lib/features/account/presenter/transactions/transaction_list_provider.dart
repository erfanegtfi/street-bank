import 'dart:async';

import 'package:app_data/model/data_response.dart';
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
  late final StreamSubscription<DataResponse<List<Transaction>?>> _subscription;

  final Ref ref;

  TransactionListNotifier(this.transactionListUsecase, this.transactionFilterUsecase, this.ref) : super(ViewState.init());

  StreamSubscription<DataResponse<List<Transaction>?>> subscribeOnTransactions() {
    state = ViewState.loading();
    _subscription = transactionListUsecase(RepositoryStrategy.offlineFirst).listen((result) {
      result.when(
        success: (transactions) {
          state = ViewState.success(transactions ?? []);
        },
        error: (error) {
          state = ViewState.error(error);
        },
      );
    });
    return _subscription;
  }

  filterList(TransactionFilterParam params) async {
    state = ViewState.success(await transactionFilterUsecase(params) ?? []);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
