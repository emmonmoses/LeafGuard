// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agent _$AgentFromJson(Map<String, dynamic> json) => Agent(
      id: json['id'] as String?,
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      document: json['document'] as String?,
      agentNumber: json['agentNumber'] as String?,
      password: json['password'] as String?,
      username: json['username'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Skillattachments.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
      description: json['description'] as String?,
      role: json['role'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AgentToJson(Agent instance) => <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone?.toJson(),
      'document': instance.document,
      'agentNumber': instance.agentNumber,
      'password': instance.password,
      'username': instance.username,
      'name': instance.name,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'email': instance.email,
      'address': instance.address,
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'description': instance.description,
      'role': instance.role,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
