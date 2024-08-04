// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permissions _$PermissionsFromJson(Map<String, dynamic> json) => Permissions(
      module: json['module'] as String?,
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => ActionMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PermissionsToJson(Permissions instance) =>
    <String, dynamic>{
      'module': instance.module,
      'actions': instance.actions?.map((e) => e.toJson()).toList(),
    };
