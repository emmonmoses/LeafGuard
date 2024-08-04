// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as String?,
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      activity: json['activity'] == null
          ? null
          : Activity.fromJson(json['activity'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      username: json['username'] as String?,
      customerNumber: json['customerNumber'] as String?,
      role: json['role'] as String?,
      email: json['email'] as String?,
      status: json['status'] as int?,
      name: json['name'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      document: json['document'] as String?,
      documentType: json['documentType'] as String?,
      avatar: json['avatar'] as String?,
      otp: json['otp'] as String?,
      device_info: json['device_info'] == null
          ? null
          : DeviceInformation.fromJson(
              json['device_info'] as Map<String, dynamic>),
      verification_code: (json['verification_code'] as List<dynamic>?)
          ?.map((e) => VerificationCode.fromJson(e as Map<String, dynamic>))
          .toList(),
      refer_history: json['refer_history'] as List<dynamic>?,
      addressList: json['addressList'] as List<dynamic>?,
      geo: (json['geo'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone?.toJson(),
      'activity': instance.activity?.toJson(),
      'address': instance.address?.toJson(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'username': instance.username,
      'document': instance.document,
      'documentType': instance.documentType,
      'dateOfBirth': instance.dateOfBirth,
      'customerNumber': instance.customerNumber,
      'role': instance.role,
      'email': instance.email,
      'status': instance.status,
      'name': instance.name,
      'avatar': instance.avatar,
      'otp': instance.otp,
      'device_info': instance.device_info?.toJson(),
      'verification_code':
          instance.verification_code?.map((e) => e.toJson()).toList(),
      'refer_history': instance.refer_history,
      'addressList': instance.addressList,
      'geo': instance.geo?.map((e) => e.toJson()).toList(),
    };
