import 'package:floor/floor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:street_bank/features/account/domain/entities/transaction.dart';
part 'transaction_data_model.g.dart';

@Entity(tableName: "transactions")
@JsonSerializable()
class TransactionDataModel {
  @PrimaryKey(autoGenerate: false)
  @JsonKey(name: "id")
  @ColumnInfo(name: "id")
  String? id;
  @JsonKey(name: "date")
  @ColumnInfo(name: "date")
  String? date;
  @JsonKey(name: "description")
  @ColumnInfo(name: "description")
  String? description;
  @JsonKey(name: "amount")
  @ColumnInfo(name: "amount")
  double? amount;
  @JsonKey(name: "beneficiary_name")
  @ColumnInfo(name: "beneficiary_name")
  String? beneficiaryName;
  @JsonKey(name: "account_number")
  @ColumnInfo(name: "account_number")
  String? accountNumber;

  TransactionDataModel({this.id, this.date, this.description, this.amount, this.beneficiaryName, this.accountNumber});

  factory TransactionDataModel.fromJson(Map<String, dynamic> json) => _$TransactionDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDataModelToJson(this);

  Transaction toEntity() {
    return Transaction(
      id: id,
      date: date,
      description: description,
      amount: amount,
      beneficiaryName: beneficiaryName,
      accountNumber: accountNumber,
    );
  }
}
