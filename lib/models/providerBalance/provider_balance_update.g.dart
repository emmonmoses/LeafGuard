// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_balance_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderBalanceUpdate _$ProviderBalanceUpdateFromJson(
        Map<String, dynamic> json) =>
    ProviderBalanceUpdate(
      id: json['id'] as String?,
      taskerNumber: json['taskerNumber'] as String?,
      taskerPhone: json['taskerPhone'] as String?,
      taskerBalance: json['taskerBalance'],
    );

Map<String, dynamic> _$ProviderBalanceUpdateToJson(
        ProviderBalanceUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskerNumber': instance.taskerNumber,
      'taskerPhone': instance.taskerPhone,
      'taskerBalance': instance.taskerBalance,
    };
