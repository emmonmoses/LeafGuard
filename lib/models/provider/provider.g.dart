// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceProvider _$ServiceProviderFromJson(Map<String, dynamic> json) =>
    ServiceProvider(
      id: json['id'] as String?,
      status: json['status'] as int?,
      taskerStatus: json['taskerStatus'] as int?,
      radius: json['radius'] as int?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      role: json['role'] as String?,
      gender: json['gender'] as String?,
      avatar: json['avatar'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      availability_address: json['availability_address'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      activity: json['activity'] == null
          ? null
          : Activity.fromJson(json['activity'] as Map<String, dynamic>),
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      birthdate: json['birthdate'] == null
          ? null
          : BirthDate.fromJson(json['birthdate'] as Map<String, dynamic>),
      experience: json['experience'] == null
          ? null
          : Experience.fromJson(json['experience'] as Map<String, dynamic>),
      nationalId: json['nationalId'] as String?,
      profile_details: (json['profile_details'] as List<dynamic>?)
          ?.map((e) => ProfileDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      verification_code: (json['verification_code'] as List<dynamic>?)
          ?.map((e) => VerificationCode.fromJson(e as Map<String, dynamic>))
          .toList(),
      document: json['document'] as String?,
      documentType: json['documentType'] as String?,
    )
      ..createdBy = json['createdBy'] as String?
      ..taskerNumber = json['taskerNumber'] as String?
      ..skillattachments = (json['skillattachments'] as List<dynamic>?)
          ?.map((e) => Skillattachments.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ServiceProviderToJson(ServiceProvider instance) =>
    <String, dynamic>{
      'id': instance.id,
      'birthdate': instance.birthdate?.toJson(),
      'phone': instance.phone?.toJson(),
      'activity': instance.activity?.toJson(),
      'radius': instance.radius,
      'createdAt': instance.createdAt?.toIso8601String(),
      'createdBy': instance.createdBy,
      'taskerNumber': instance.taskerNumber,
      'username': instance.username,
      'gender': instance.gender,
      'email': instance.email,
      'role': instance.role,
      'avatar': instance.avatar,
      'availability_address': instance.availability_address,
      'experience': instance.experience?.toJson(),
      'skillattachments':
          instance.skillattachments?.map((e) => e.toJson()).toList(),
      'profile_details':
          instance.profile_details?.map((e) => e.toJson()).toList(),
      'taskerStatus': instance.taskerStatus,
      'status': instance.status,
      'name': instance.name,
      'verification_code':
          instance.verification_code?.map((e) => e.toJson()).toList(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'password': instance.password,
      'document': instance.document,
      'documentType': instance.documentType,
      'location': instance.location?.toJson(),
      'address': instance.address?.toJson(),
      'nationalId': instance.nationalId,
    };
