// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'witnessresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WitnessResponse _$WitnessResponseFromJson(Map<String, dynamic> json) =>
    WitnessResponse(
      id: json['id'] as String?,
      taskerId: json['taskerId'] as String?,
      witnesses: (json['witnesses'] as List<dynamic>?)
          ?.map((e) => Witness.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WitnessResponseToJson(WitnessResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskerId': instance.taskerId,
      'witnesses': instance.witnesses?.map((e) => e.toJson()).toList(),
    };
