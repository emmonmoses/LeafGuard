// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingCreate _$BillingCreateFromJson(Map<String, dynamic> json) =>
    BillingCreate(
      billing_period: json['billing_period'] as String?,
      valid_from: json['valid_from'] as String?,
      valid_to: json['valid_to'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$BillingCreateToJson(BillingCreate instance) =>
    <String, dynamic>{
      'billing_period': instance.billing_period,
      'valid_from': instance.valid_from,
      'valid_to': instance.valid_to,
      'status': instance.status,
    };
