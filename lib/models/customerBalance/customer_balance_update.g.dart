// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_balance_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerBalanceUpdate _$CustomerBalanceUpdateFromJson(
        Map<String, dynamic> json) =>
    CustomerBalanceUpdate(
      id: json['id'] as String?,
      customerNumber: json['customerNumber'] as String?,
      customerPhone: json['customerPhone'] as String?,
      customerBalance: json['customerBalance'],
    );

Map<String, dynamic> _$CustomerBalanceUpdateToJson(
        CustomerBalanceUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerNumber': instance.customerNumber,
      'customerPhone': instance.customerPhone,
      'customerBalance': instance.customerBalance,
    };
