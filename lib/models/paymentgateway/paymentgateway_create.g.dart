// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentgateway_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentGatewayCreate _$PaymentGatewayCreateFromJson(
        Map<String, dynamic> json) =>
    PaymentGatewayCreate(
      payment_gateway: json['payment_gateway'] as String?,
      gateway_alias: json['gateway_alias'] as String?,
      gateway_settings: json['gateway_settings'] == null
          ? null
          : GatewaySetting.fromJson(
              json['gateway_settings'] as Map<String, dynamic>),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$PaymentGatewayCreateToJson(
        PaymentGatewayCreate instance) =>
    <String, dynamic>{
      'payment_gateway': instance.payment_gateway,
      'gateway_alias': instance.gateway_alias,
      'gateway_settings': instance.gateway_settings?.toJson(),
      'status': instance.status,
    };
