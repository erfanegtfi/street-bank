import 'dart:async';

import 'package:app_data/general_error.dart';
import 'package:app_data/model/data_response.dart';
import 'package:app_data/remote/exception/network_connection_exception.dart';
import 'package:app_data/repository_strategy.dart';
import 'package:app_utils/constants.dart';
import 'package:app_utils/states/view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:street_bank/di/injector.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/usecase/transaction_list_usecase.dart';
import 'package:rxdart/rxdart.dart';

final dashboardTransactionListProvider = StateNotifierProvider.autoDispose<DashboardTransactionListNotifier, ViewState<List<Transaction>>>((
  ref,
) {
  TransactionListUsecase transactionListUsecase = locator<TransactionListUsecase>();

  return DashboardTransactionListNotifier(transactionListUsecase, ref);
});

class DashboardTransactionListNotifier extends StateNotifier<ViewState<List<Transaction>>> {
  final TransactionListUsecase transactionListUsecase;
  StreamSubscription<DataResponse<List<Transaction>?>>? _subscription;
  final PublishSubject<GeneralError> errorPublisher = PublishSubject();

  List<Transaction> transactions = [];
  final Ref ref;

  DashboardTransactionListNotifier(this.transactionListUsecase, this.ref) : super(ViewState.init());

  void fetchTransactions() async {
    state = ViewState.loading();
    await _subscription?.cancel();
    _subscription = transactionListUsecase(RepositoryStrategy.offlineFirst).listen((result) {
      result.when(
        success: (transactions) {
          this.transactions = transactions ?? [];
          if ((transactions?.length ?? 0) >= Constants.homeTrasactionListCount)
            state = ViewState.success(transactions!.sublist(0, Constants.homeTrasactionListCount));
          else
            state = ViewState.success(transactions ?? []);
        },
        error: (error) {
          //  && error.appException is NetworkConnectionException
          if (transactions.isEmpty)
            state = ViewState.error(error);
          else
            errorPublisher.add(error);
        },
      );
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    errorPublisher.close();

    super.dispose();
  }
}
