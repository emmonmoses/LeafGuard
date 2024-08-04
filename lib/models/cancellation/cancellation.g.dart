// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancellation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancellationRules _$CancellationRulesFromJson(Map<String, dynamic> json) =>
    CancellationRules(
      id: json['id'] as String?,
      type: json['type'] as String?,
      reason: json['reason'] as String?,
      status: json['status'] as int? ?? 1,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      date: json['date'] as String?,
    );

Map<String, dynamic> _$CancellationRulesToJson(CancellationRules instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'reason': instance.reason,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'date': instance.date,
    };
