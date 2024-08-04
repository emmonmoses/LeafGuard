// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxCategoryUpdate _$TaxCategoryUpdateFromJson(Map<String, dynamic> json) =>
    TaxCategoryUpdate(
      name: json['name'] as String?,
      rate: json['rate'] as String?,
      type: json['type'] as bool?,
    );

Map<String, dynamic> _$TaxCategoryUpdateToJson(TaxCategoryUpdate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rate': instance.rate,
      'type': instance.type,
    };
