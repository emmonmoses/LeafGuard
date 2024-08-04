// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_catagory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxCatagory _$TaxCatagoryFromJson(Map<String, dynamic> json) => TaxCatagory(
      name: json['name'] as String? ?? "VAT",
      rate: json['rate'] as String?,
      type: json['type'] as bool? ?? true,
    );

Map<String, dynamic> _$TaxCatagoryToJson(TaxCatagory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'rate': instance.rate,
    };
