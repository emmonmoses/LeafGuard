// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Administrator _$AdministratorFromJson(Map<String, dynamic> json) =>
    Administrator(
      status: json['status'] as int? ?? 1,
      id: json['id'] as String?,
      adminNumber: json['adminNumber'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      username: json['username'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      activity: json['activity'] == null
          ? null
          : Activity.fromJson(json['activity'] as Map<String, dynamic>),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permissions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdministratorToJson(Administrator instance) =>
    <String, dynamic>{
      'status': instance.status,
      'id': instance.id,
      'adminNumber': instance.adminNumber,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'username': instance.username,
      'createdAt': instance.createdAt?.toIso8601String(),
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'activity': instance.activity?.toJson(),
      'permissions': instance.permissions?.map((e) => e.toJson()).toList(),
    };
