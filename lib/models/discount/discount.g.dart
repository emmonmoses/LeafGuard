// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Discount _$DiscountFromJson(Map<String, dynamic> json) => Discount(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      discount_type: json['discount_type'] as String?,
      rate: json['rate'],
      amount_percentage: json['amount_percentage'],
      amount: json['amount'],
      description: json['description'] as String?,
      status: json['status'] as int?,
      expiry_date: json['expiry_date'] == null
          ? null
          : DateTime.parse(json['expiry_date'] as String),
      valid_from: json['valid_from'] == null
          ? null
          : DateTime.parse(json['valid_from'] as String),
    );

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'name': instance.name,
      'code': instance.code,
      'discount_type': instance.discount_type,
      'rate': instance.rate,
      'amount_percentage': instance.amount_percentage,
      'amount': instance.amount,
      'description': instance.description,
      'status': instance.status,
      'expiry_date': instance.expiry_date?.toIso8601String(),
      'valid_from': instance.valid_from?.toIso8601String(),
    };
