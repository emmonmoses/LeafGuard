// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdministratorCreate _$AdministratorCreateFromJson(Map<String, dynamic> json) =>
    AdministratorCreate(
      status: json['status'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$AdministratorCreateToJson(
        AdministratorCreate instance) =>
    <String, dynamic>{
      'status': instance.status,
      'name': instance.name,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
    };
