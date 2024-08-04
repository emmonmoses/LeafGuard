// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tax _$TaxFromJson(Map<String, dynamic> json) => Tax(
      id: json['id'] as String?,
      name: json['name'] as String?,
      rate: json['rate'],
      type: json['type'],
      amount_percentage: json['amount_percentage'],
      amount: json['amount'],
      description: json['description'] as String?,
      status: json['status'] as int?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$TaxToJson(Tax instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rate': instance.rate,
      'type': instance.type,
      'amount_percentage': instance.amount_percentage,
      'amount': instance.amount,
      'description': instance.description,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
