// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDataModel _$TransactionDataModelFromJson(
        Map<String, dynamic> json) =>
    TransactionDataModel(
      id: json['id'] as String?,
      date: json['date'] as String?,
      description: json['description'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      beneficiaryName: json['beneficiary_name'] as String?,
      accountNumber: json['account_number'] as String?,
    );

Map<String, dynamic> _$TransactionDataModelToJson(
        TransactionDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'description': instance.description,
      'amount': instance.amount,
      'beneficiary_name': instance.beneficiaryName,
      'account_number': instance.accountNumber,
    };
