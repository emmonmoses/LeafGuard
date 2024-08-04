// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      id: json['id'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      symbol: json['symbol'] as String?,
      value: json['value'] as String?,
      featured: json['featured'] as int?,
      status: json['status'] as int? ?? 1,
      default_currency: json['default_currency'] as int?,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'symbol': instance.symbol,
      'value': instance.value,
      'featured': instance.featured,
      'status': instance.status,
      'default_currency': instance.default_currency,
    };
