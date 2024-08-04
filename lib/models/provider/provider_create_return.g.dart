// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_create_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderCreateReturn _$ProviderCreateReturnFromJson(
        Map<String, dynamic> json) =>
    ProviderCreateReturn(
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
      password: json['password'] as String?,
      profile_details: (json['profile_details'] as List<dynamic>?)
          ?.map((e) => ProfileDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
      experience: json['experience'] as String?,
      status: json['status'] as int?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Skillattachments.fromJson(e as Map<String, dynamic>))
          .toList(),
      taskerStatus: json['taskerStatus'] as int?,
      createdBy: json['createdBy'] as String?,
      availability_address: json['availability_address'] as String?,
      document: json['document'] as String?,
      documentType: json['documentType'] as String?,
    )
      ..id = json['id'] as String?
      ..taskerNumber = json['taskerNumber'] as String?;

Map<String, dynamic> _$ProviderCreateReturnToJson(
        ProviderCreateReturn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'gender': instance.gender,
      'birthdate': instance.birthdate?.toJson(),
      'email': instance.email,
      'phone': instance.phone?.toJson(),
      'avatar': instance.avatar,
      'password': instance.password,
      'profile_details':
          instance.profile_details?.map((e) => e.toJson()).toList(),
      'availability_address': instance.availability_address,
      'experience': instance.experience,
      'status': instance.status,
      'taskerStatus': instance.taskerStatus,
      'taskerNumber': instance.taskerNumber,
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'createdBy': instance.createdBy,
      'document': instance.document,
      'documentType': instance.documentType,
    };
