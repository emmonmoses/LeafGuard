// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyUpdate _$CurrencyUpdateFromJson(Map<String, dynamic> json) =>
    CurrencyUpdate(
      id: json['id'] as String,
      currency_name: json['currency_name'] as String,
      currency_code: json['currency_code'] as String?,
      currency_symbol: json['currency_symbol'] as String?,
      currency_value: json['currency_value'] as int?,
      currency_status: json['currency_status'] as int?,
    );

Map<String, dynamic> _$CurrencyUpdateToJson(CurrencyUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currency_name': instance.currency_name,
      'currency_code': instance.currency_code,
      'currency_symbol': instance.currency_symbol,
      'currency_value': instance.currency_value,
      'currency_status': instance.currency_status,
    };
