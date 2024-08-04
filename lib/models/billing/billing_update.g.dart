// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingUpdate _$BillingUpdateFromJson(Map<String, dynamic> json) =>
    BillingUpdate(
      id: json['id'] as String,
      billing_period: json['billing_period'] as String?,
      valid_from: json['valid_from'] as String?,
      valid_to: json['valid_to'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$BillingUpdateToJson(BillingUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'billing_period': instance.billing_period,
      'valid_from': instance.valid_from,
      'valid_to': instance.valid_to,
      'status': instance.status,
    };
