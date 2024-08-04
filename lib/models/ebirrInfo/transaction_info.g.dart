// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionInfo _$TransactionInfoFromJson(Map<String, dynamic> json) =>
    TransactionInfo(
      amount: json['amount'] as String,
      currency: json['currency'] as String,
      description: json['description'] as String,
      referenceId: json['referenceId'] as String,
      invoiceId: json['invoiceId'] as String,
    );

Map<String, dynamic> _$TransactionInfoToJson(TransactionInfo instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'description': instance.description,
      'referenceId': instance.referenceId,
      'invoiceId': instance.invoiceId,
    };
