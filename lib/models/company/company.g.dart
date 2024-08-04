// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      address: json['address'] == null
          ? null
          : CompanyAddress.fromJson(json['address'] as Map<String, dynamic>),
      avatar: json['avatar'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      code: json['code'] as String?,
      createdOn: json['createdOn'] as String?,
      currency: json['currency'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      pricing: json['pricing'] == null
          ? null
          : CompanyPrice.fromJson(json['pricing'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      tinnumber: json['tinnumber'] as String?,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'name': instance.name,
      'category': instance.category?.toJson(),
      'currency': instance.currency,
      'createdOn': instance.createdOn,
      'code': instance.code,
      'tinnumber': instance.tinnumber,
      'description': instance.description,
      'avatar': instance.avatar,
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone?.toJson(),
      'address': instance.address?.toJson(),
      'pricing': instance.pricing?.toJson(),
      'status': instance.status,
    };
