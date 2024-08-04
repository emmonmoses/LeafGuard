// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxCreate _$TaxCreateFromJson(Map<String, dynamic> json) => TaxCreate(
      name: json['name'] as String?,
      rate: json['rate'] as int?,
      description: json['description'] as String?,
      status: json['status'] as int? ?? 1,
    );

Map<String, dynamic> _$TaxCreateToJson(TaxCreate instance) => <String, dynamic>{
      'name': instance.name,
      'rate': instance.rate,
      'description': instance.description,
      'status': instance.status,
    };
