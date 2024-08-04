// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderBalance _$ProviderBalanceFromJson(Map<String, dynamic> json) =>
    ProviderBalance(
      id: json['id'] as String?,
      taskerId: json['taskerId'] as String?,
      taskerBalance: (json['taskerBalance'] as num?)?.toDouble(),
      tasker: json['tasker'] == null
          ? null
          : ServiceProvider.fromJson(json['tasker'] as Map<String, dynamic>),
      transactionDate: json['transactionDate'] == null
          ? null
          : DateTime.parse(json['transactionDate'] as String),
      transactionId: json['transactionId'] as String?,
    );

Map<String, dynamic> _$ProviderBalanceToJson(ProviderBalance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskerId': instance.taskerId,
      'taskerBalance': instance.taskerBalance,
      'tasker': instance.tasker?.toJson(),
      'transactionDate': instance.transactionDate?.toIso8601String(),
      'transactionId': instance.transactionId,
    };
