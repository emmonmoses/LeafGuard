// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'witnesses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Witnesses _$WitnessesFromJson(Map<String, dynamic> json) => Witnesses(
      id: json['id'] as String?,
      taskerId: json['taskerId'] as String?,
      witnesses: (json['witnesses'] as List<dynamic>?)
          ?.map((e) => Witness.fromJson(e as Map<String, dynamic>))
          .toList(),
      tasker: json['tasker'] == null
          ? null
          : ServiceProvider.fromJson(json['tasker'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WitnessesToJson(Witnesses instance) => <String, dynamic>{
      'id': instance.id,
      'taskerId': instance.taskerId,
      'witnesses': instance.witnesses?.map((e) => e.toJson()).toList(),
      'tasker': instance.tasker?.toJson(),
    };
