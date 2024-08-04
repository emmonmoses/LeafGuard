// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_recharge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceRecharge _$BalanceRechargeFromJson(Map<String, dynamic> json) =>
    BalanceRecharge(
      schemaVersion: json['schemaVersion'] as String? ?? "1.0",
      requestId: json['requestId'] as String? ?? "RjEV1zQ0lTbA4oe7g",
      timestamp: json['timestamp'] as String? ?? "RjEV1zQ0lTbA4oe7g",
      channelName: json['channelName'] as String? ?? "WEB",
      serviceName: json['serviceName'] as String? ?? "API_PURCHASE",
      serviceParams:
          ServiceParams.fromJson(json['serviceParams'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BalanceRechargeToJson(BalanceRecharge instance) =>
    <String, dynamic>{
      'schemaVersion': instance.schemaVersion,
      'requestId': instance.requestId,
      'timestamp': instance.timestamp,
      'channelName': instance.channelName,
      'serviceName': instance.serviceName,
      'serviceParams': instance.serviceParams.toJson(),
    };
