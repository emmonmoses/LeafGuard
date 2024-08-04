// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gatewaysetting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GatewaySetting _$GatewaySettingFromJson(Map<String, dynamic> json) =>
    GatewaySetting(
      redirect_uri: json['redirect_uri'] as String?,
      publishable_key: json['publishable_key'] as String?,
      secret_key: json['secret_key'] as String?,
      mode: json['mode'] as String?,
      client_key: json['client_key'] as String?,
      sandbox_secret_key: json['sandbox_secret_key'] as String?,
      live_secret_key: json['live_secret_key'] as String?,
    );

Map<String, dynamic> _$GatewaySettingToJson(GatewaySetting instance) =>
    <String, dynamic>{
      'redirect_uri': instance.redirect_uri,
      'publishable_key': instance.publishable_key,
      'secret_key': instance.secret_key,
      'mode': instance.mode,
      'client_key': instance.client_key,
      'sandbox_secret_key': instance.sandbox_secret_key,
      'live_secret_key': instance.live_secret_key,
    };
