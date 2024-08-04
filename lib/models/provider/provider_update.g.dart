// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderUpdate _$ProviderUpdateFromJson(Map<String, dynamic> json) =>
    ProviderUpdate(
      id: json['id'] as String,
      username: json['username'] as String?,
      gender: json['gender'] as String?,
      birthdate: json['birthdate'] == null
          ? null
          : BirthDate.fromJson(json['birthdate'] as Map<String, dynamic>),
      email: json['email'] as String?,
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      avatar: json['avatar'] as String?,
      profile_details: (json['profile_details'] as List<dynamic>?)
          ?.map((e) => ProfileDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      experienceId: json['experienceId'] as String?,
      status: json['status'] as int?,
      skillattachments: (json['skillattachments'] as List<dynamic>?)
          ?.map((e) => Skillattachments.fromJson(e as Map<String, dynamic>))
          .toList(),
      taskerStatus: json['taskerStatus'] as int?,
      availability_address: json['availability_address'] as String?,
      createdBy: json['createdBy'] as String?,
      document: json['document'] as String?,
      documentType: json['documentType'] as String?,
    );

Map<String, dynamic> _$ProviderUpdateToJson(ProviderUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'gender': instance.gender,
      'birthdate': instance.birthdate?.toJson(),
      'email': instance.email,
      'phone': instance.phone?.toJson(),
      'avatar': instance.avatar,
      'profile_details':
          instance.profile_details?.map((e) => e.toJson()).toList(),
      'availability_address': instance.availability_address,
      'experienceId': instance.experienceId,
      'status': instance.status,
      'taskerStatus': instance.taskerStatus,
      'skillattachments':
          instance.skillattachments?.map((e) => e.toJson()).toList(),
      'document': instance.document,
      'documentType': instance.documentType,
      'createdBy': instance.createdBy,
    };
