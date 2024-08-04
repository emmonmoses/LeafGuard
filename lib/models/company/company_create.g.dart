// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyCreate _$CompanyCreateFromJson(Map<String, dynamic> json) =>
    CompanyCreate(
      name: json['name'] as String?,
      address: json['address'] == null
          ? null
          : CompanyAddress.fromJson(json['address'] as Map<String, dynamic>),
      avatar: json['avatar'] as String?,
      categoryId: json['categoryId'] as String?,
      currency: json['currency'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] == null
          ? null
          : Phone.fromJson(json['phone'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      tinnumber: json['tinnumber'] as String?,
      pricing: json['pricing'] == null
          ? null
          : CompanyPrice.fromJson(json['pricing'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompanyCreateToJson(CompanyCreate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('currency', instance.currency);
  writeNotNull('tinnumber', instance.tinnumber);
  writeNotNull('description', instance.description);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('email', instance.email);
  writeNotNull('phone', instance.phone?.toJson());
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('pricing', instance.pricing?.toJson());
  writeNotNull('status', instance.status);
  return val;
}
