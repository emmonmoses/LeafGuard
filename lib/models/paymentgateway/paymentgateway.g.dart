// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentgateway.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentGateway _$PaymentGatewayFromJson(Map<String, dynamic> json) =>
    PaymentGateway(
      id: json['id'] as String?,
      gateway_name: json['gateway_name'] as String?,
      alias: json['alias'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] as String?,
      status: json['status'] as int? ?? 1,
      settings: json['settings'] == null
          ? null
          : GatewaySetting.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentGatewayToJson(PaymentGateway instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gateway_name': instance.gateway_name,
      'alias': instance.alias,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt,
      'status': instance.status,
      'settings': instance.settings?.toJson(),
    };
