// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subadmin_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubAdministratorCreate _$SubAdministratorCreateFromJson(
        Map<String, dynamic> json) =>
    SubAdministratorCreate(
      status: json['status'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permissions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubAdministratorCreateToJson(
        SubAdministratorCreate instance) =>
    <String, dynamic>{
      'status': instance.status,
      'name': instance.name,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'permissions': instance.permissions?.map((e) => e.toJson()).toList(),
    };
