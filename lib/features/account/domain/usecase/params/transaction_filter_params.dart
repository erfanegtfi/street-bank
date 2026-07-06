import 'package:street_bank/features/account/domain/entities/transaction.dart';
import 'package:street_bank/features/account/domain/usecase/params/transaction_type.dart';

class TransactionFilterParam {
  String? name;
  TransactionTyoe? type;
  List<Transaction>? transactions;
  TransactionFilterParam({this.name, this.type, required this.transactions});
}
