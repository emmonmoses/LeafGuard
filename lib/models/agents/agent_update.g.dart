// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgentUpdate _$AgentUpdateFromJson(Map<String, dynamic> json) => AgentUpdate(
      id: json['id'] as String,
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      agentNumber: json['agentNumber'] as String?,
      username: json['username'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      document: json['document'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Skillattachments.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
      description: json['description'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$AgentUpdateToJson(AgentUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone?.toJson(),
      'agentNumber': instance.agentNumber,
      'username': instance.username,
      'name': instance.name,
      'avatar': instance.avatar,
      'document': instance.document,
      'gender': instance.gender,
      'email': instance.email,
      'address': instance.address,
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'description': instance.description,
      'role': instance.role,
    };
