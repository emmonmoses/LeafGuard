// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'witness_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WitnessUpdate _$WitnessUpdateFromJson(Map<String, dynamic> json) =>
    WitnessUpdate(
      id: json['id'] as String?,
      taskerId: json['taskerId'] as String?,
      taskerWitnesses: (json['taskerWitnesses'] as List<dynamic>)
          .map((e) => Witness.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WitnessUpdateToJson(WitnessUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskerId': instance.taskerId,
      'taskerWitnesses':
          instance.taskerWitnesses.map((e) => e.toJson()).toList(),
    };
