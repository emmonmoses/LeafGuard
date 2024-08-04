// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerCreate _$CustomerCreateFromJson(Map<String, dynamic> json) =>
    CustomerCreate(
      status: json['status'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      avatar: json['avatar'] as String?,
      document: json['document'] as String?,
      documentType: json['documentType'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
    );

Map<String, dynamic> _$CustomerCreateToJson(CustomerCreate instance) =>
    <String, dynamic>{
      'status': instance.status,
      'name': instance.name,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'address': instance.address?.toJson(),
      'phone': instance.phone?.toJson(),
      'avatar': instance.avatar,
      'document': instance.document,
      'dateOfBirth': instance.dateOfBirth,
      'documentType': instance.documentType,
    };
