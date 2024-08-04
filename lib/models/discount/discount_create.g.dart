// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountCreate _$DiscountCreateFromJson(Map<String, dynamic> json) =>
    DiscountCreate(
      name: json['name'] as String?,
      rate: json['rate'] as int?,
      description: json['description'] as String?,
      status: json['status'] ?? 1,
      code: json['code'] as String?,
      discount_type: json['discount_type'] as String?,
      valid_from: json['valid_from'] as String?,
      expiry_date: json['expiry_date'] as String?,
    );

Map<String, dynamic> _$DiscountCreateToJson(DiscountCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'discount_type': instance.discount_type,
      'rate': instance.rate,
      'description': instance.description,
      'status': instance.status,
      'valid_from': instance.valid_from,
      'expiry_date': instance.expiry_date,
    };
