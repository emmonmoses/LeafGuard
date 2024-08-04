// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerBalance _$CustomerBalanceFromJson(Map<String, dynamic> json) =>
    CustomerBalance(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      customerBalance: (json['customerBalance'] as num?)?.toDouble(),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      transactionDate: json['transactionDate'] == null
          ? null
          : DateTime.parse(json['transactionDate'] as String),
      transactionId: json['transactionId'] as String?,
    );

Map<String, dynamic> _$CustomerBalanceToJson(CustomerBalance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'customerBalance': instance.customerBalance,
      'customer': instance.customer?.toJson(),
      'transactionDate': instance.transactionDate?.toIso8601String(),
      'transactionId': instance.transactionId,
    };
