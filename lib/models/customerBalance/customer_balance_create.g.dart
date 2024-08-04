// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_balance_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerBalanceCreate _$CustomerBalanceCreateFromJson(
        Map<String, dynamic> json) =>
    CustomerBalanceCreate(
      customerId: json['customerId'] as String?,
      customerBalance: (json['customerBalance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CustomerBalanceCreateToJson(
        CustomerBalanceCreate instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'customerBalance': instance.customerBalance,
    };
