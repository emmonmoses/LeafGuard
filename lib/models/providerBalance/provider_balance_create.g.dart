// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_balance_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderBalanceCreate _$ProviderBalanceCreateFromJson(
        Map<String, dynamic> json) =>
    ProviderBalanceCreate(
      taskerId: json['taskerId'] as String?,
      taskerBalance: (json['taskerBalance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProviderBalanceCreateToJson(
        ProviderBalanceCreate instance) =>
    <String, dynamic>{
      'taskerId': instance.taskerId,
      'taskerBalance': instance.taskerBalance,
    };
