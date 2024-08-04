// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyCreate _$CurrencyCreateFromJson(Map<String, dynamic> json) =>
    CurrencyCreate(
      currency_name: json['currency_name'] as String?,
      currency_code: json['currency_code'] as String?,
      currency_symbol: json['currency_symbol'] as String?,
      currency_value: json['currency_value'] as int?,
      currency_status: json['currency_status'] as int?,
    );

Map<String, dynamic> _$CurrencyCreateToJson(CurrencyCreate instance) =>
    <String, dynamic>{
      'currency_name': instance.currency_name,
      'currency_code': instance.currency_code,
      'currency_symbol': instance.currency_symbol,
      'currency_value': instance.currency_value,
      'currency_status': instance.currency_status,
    };
