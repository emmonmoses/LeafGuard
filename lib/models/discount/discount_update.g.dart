// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountUpdate _$DiscountUpdateFromJson(Map<String, dynamic> json) =>
    DiscountUpdate(
      id: json['id'] as String,
      name: json['name'] as String?,
      code: json['code'] as String?,
      discount_type: json['discount_type'] as String?,
      description: json['description'] as String?,
      rate: json['rate'] as String?,
      amount_percentage: json['amount_percentage'] as String?,
      valid_from: json['valid_from'] as String?,
      expiry_date: json['expiry_date'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$DiscountUpdateToJson(DiscountUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'discount_type': instance.discount_type,
      'description': instance.description,
      'rate': instance.rate,
      'amount_percentage': instance.amount_percentage,
      'valid_from': instance.valid_from,
      'expiry_date': instance.expiry_date,
      'status': instance.status,
    };
