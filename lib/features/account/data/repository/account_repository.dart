import 'dart:async';
import 'package:app_data/general_error.dart';
import 'package:app_data/model/data_response.dart';
import 'package:app_data/model/list_response.dart';
import 'package:app_data/remote/run_service.dart';
import 'package:design_system/app_text.dart';
import 'package:street_bank/features/account/data/data_source/local/account_local_storage_impl.dart';
import 'package:street_bank/features/account/data/data_source/local/transaction_local_data_source.dart';
import 'package:street_bank/features/account/data/data_source/remote/account_remote_data_source.dart';
import 'package:street_bank/features/account/data/model/transaction_data_model.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/repositories/account_repository.dart';
import 'package:street_bank/features/account/domain/usecase/params/transfer_balance_params.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource accountRemoteDataSource;
  final TransactionsLocalDataSource transactionsLocalDataSource;
  final AccountLocalStorage accountLocalStorage;

  AccountRepositoryImpl({
    required this.accountRemoteDataSource,
    required this.transactionsLocalDataSource,
    required this.accountLocalStorage,
  });

  @override
  Future<DataResponse<List<Transaction>?>> getAllTransactionsRemote() async {
    DataResponse<List<Transaction>?> dataResponse;

    dataResponse = await runService(
      apiCall: () async {
        ListResponse<TransactionDataModel> response = await accountRemoteDataSource.getAllTransactions();
        if (response.result != null && response.result?.isNotEmpty == true) {
          transactionsLocalDataSource.insertTransactions(response.result!);

          return DataResponse.success(response.result?.map((trans) => trans.toEntity()).toList());
        } else {
          return DataResponse.success(List.empty());
        }
      },
      onDioError: (error) {
        return DataResponse.error(GeneralError.withDioError(error));
      },
      onUnknownError: (error) {
        return DataResponse.error(GeneralError.withMessage(AppText.errorUnknown));
      },
    );

    return dataResponse;
  }

  @override
  Future<List<Transaction>?> getAllTransactionsLocal() async {
    List<TransactionDataModel> response = await transactionsLocalDataSource.getAllTransactions();
    return response.map((trans) => trans.toEntity()).toList();
  }

  @override
  void setUserBalance(double balance) {
    accountLocalStorage.setUserBalance(balance);
  }

  @override
  double? getUserBalance() {
    return accountLocalStorage.getUserBalance();
  }

  @override
  Future<bool> addTransaction(TransferBalanceParams transaction) async {
    var response = await transactionsLocalDataSource.insertTransaction(
      TransactionDataModel(
        id: transaction.id,
        date: transaction.date,
        description: transaction.description,
        amount: transaction.amount,
        beneficiaryName: transaction.beneficiaryName,
        accountNumber: transaction.accountNumber,
      ),
    );
    return true;
  }
}
