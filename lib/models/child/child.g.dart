// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      action: json['action'] as String?,
      state: json['state'] as String?,
      alias: json['alias'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'action': instance.action,
      'state': instance.state,
      'alias': instance.alias,
      'name': instance.name,
    };
