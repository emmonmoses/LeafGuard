// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'witness_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WitnessCreate _$WitnessCreateFromJson(Map<String, dynamic> json) =>
    WitnessCreate(
      taskerId: json['taskerId'] as String?,
      taskerWitnesses: (json['taskerWitnesses'] as List<dynamic>)
          .map((e) => Witness.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WitnessCreateToJson(WitnessCreate instance) =>
    <String, dynamic>{
      'taskerId': instance.taskerId,
      'taskerWitnesses':
          instance.taskerWitnesses.map((e) => e.toJson()).toList(),
    };
