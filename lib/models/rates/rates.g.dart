// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateType _$RateTypeFromJson(Map<String, dynamic> json) => RateType(
      type: json['type'] as String?,
      amount: json['amount'] as int?,
    );

Map<String, dynamic> _$RateTypeToJson(RateType instance) => <String, dynamic>{
      'type': instance.type,
      'amount': instance.amount,
    };
