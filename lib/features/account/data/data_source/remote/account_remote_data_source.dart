import 'package:app_data/model/list_response.dart';
import 'package:injectable/injectable.dart';
import 'package:street_bank/features/account/data/data_source/remote/account_rest_client.dart';
import 'package:street_bank/features/account/data/model/transaction_data_model.dart';

abstract class AccountRemoteDataSource {
  Future<ListResponse<TransactionDataModel>> getAllTransactions();
}

@Injectable(as: AccountRemoteDataSource)
class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final AccountRestClient restClient;

  AccountRemoteDataSourceImpl({required this.restClient});

  @override
  Future<ListResponse<TransactionDataModel>> getAllTransactions() {
    return restClient.getTransactions();
  }
}
