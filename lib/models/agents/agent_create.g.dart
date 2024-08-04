// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgentCreate _$AgentCreateFromJson(Map<String, dynamic> json) => AgentCreate(
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      username: json['username'] as String?,
      document: json['document'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      address: json['address'] as String?,
      status: json['status'] as int?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$AgentCreateToJson(AgentCreate instance) =>
    <String, dynamic>{
      'phone': instance.phone?.toJson(),
      'username': instance.username,
      'document': instance.document,
      'name': instance.name,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'email': instance.email,
      'password': instance.password,
      'address': instance.address,
      'status': instance.status,
      'description': instance.description,
    };
