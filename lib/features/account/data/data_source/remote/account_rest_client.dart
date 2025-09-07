import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:street_bank/features/account/data/model/transaction_data_model.dart';
import 'package:app_data/model/index_app_response.dart';

part 'account_rest_client.g.dart';

@injectable
@RestApi()
abstract class AccountRestClient {
  @factoryMethod
  factory AccountRestClient(Dio dio, {@Named("baseUrl") String baseUrl}) = _AccountRestClient;

  @GET("erfanegtfi/bank/db")
  Future<ListResponse<TransactionDataModel>> getTransactions();
}
