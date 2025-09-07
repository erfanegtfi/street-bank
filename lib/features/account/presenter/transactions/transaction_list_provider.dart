import 'dart:async';

import 'package:app_data/model/data_response.dart';
import 'package:app_data/repository_strategy.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_list_usecase.dart';

final transactionListProvider = StateNotifierProvider.autoDispose<TransactionListNotifier, ViewState<List<Transaction>>>((ref) {
  TransactionListUsecase transactionListUsecase = locator<TransactionListUsecase>();

  return TransactionListNotifier(transactionListUsecase, ref);
});

class TransactionListNotifier extends StateNotifier<ViewState<List<Transaction>>> {
  final TransactionListUsecase transactionListUsecase;
  late final StreamSubscription<DataResponse<List<Transaction>?>> _subscription;

  final Ref ref;

  TransactionListNotifier(this.transactionListUsecase, this.ref) : super(ViewState.init());

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

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
