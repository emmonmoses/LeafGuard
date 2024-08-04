// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentgateway_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentGatewayUpdate _$PaymentGatewayUpdateFromJson(
        Map<String, dynamic> json) =>
    PaymentGatewayUpdate(
      id: json['id'] as String?,
      payment_gateway: json['payment_gateway'] as String?,
      gateway_alias: json['gateway_alias'] as String?,
      gateway_settings: json['gateway_settings'] == null
          ? null
          : GatewaySetting.fromJson(
              json['gateway_settings'] as Map<String, dynamic>),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$PaymentGatewayUpdateToJson(
        PaymentGatewayUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payment_gateway': instance.payment_gateway,
      'gateway_alias': instance.gateway_alias,
      'gateway_settings': instance.gateway_settings?.toJson(),
      'status': instance.status,
    };
