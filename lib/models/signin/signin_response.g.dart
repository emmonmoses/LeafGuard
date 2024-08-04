// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponse _$SignInResponseFromJson(Map<String, dynamic> json) =>
    SignInResponse(
      status: json['status'] as int?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      admin: json['admin'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permissions.fromJson(e as Map<String, dynamic>))
          .toList(),
      role: json['role'] as String?,
      token: json['token'] as String?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$SignInResponseToJson(SignInResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'id': instance.id,
      'name': instance.name,
      'admin': instance.admin,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'permissions': instance.permissions?.map((e) => e.toJson()).toList(),
      'role': instance.role,
      'token': instance.token,
      'created': instance.created,
    };
