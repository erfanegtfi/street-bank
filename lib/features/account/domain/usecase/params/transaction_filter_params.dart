import 'package:street_bank/features/account/domain/usecase/params/transaction_type.dart';

class TransactionFilterParam {
  String? name;
  TransactionTyoe? type;

  TransactionFilterParam({this.name, this.type});
}
