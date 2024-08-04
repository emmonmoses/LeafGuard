// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_witness.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressWitness _$AddressWitnessFromJson(Map<String, dynamic> json) =>
    AddressWitness(
      line: json['line'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$AddressWitnessToJson(AddressWitness instance) =>
    <String, dynamic>{
      'line': instance.line,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };
