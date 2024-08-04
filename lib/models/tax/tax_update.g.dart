// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxUpdate _$TaxUpdateFromJson(Map<String, dynamic> json) => TaxUpdate(
      id: json['id'] as String,
      name: json['name'] as String?,
      rate: json['rate'] as int?,
      description: json['description'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$TaxUpdateToJson(TaxUpdate instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rate': instance.rate,
      'description': instance.description,
      'status': instance.status,
    };
