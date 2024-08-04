// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'witness.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Witness _$WitnessFromJson(Map<String, dynamic> json) => Witness(
      nationalId: json['nationalId'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      document: json['document'] as String?,
      address: json['address'] == null
          ? null
          : AddressWitness.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WitnessToJson(Witness instance) => <String, dynamic>{
      'nationalId': instance.nationalId,
      'name': instance.name,
      'phone': instance.phone,
      'document': instance.document,
      'address': instance.address?.toJson(),
    };
