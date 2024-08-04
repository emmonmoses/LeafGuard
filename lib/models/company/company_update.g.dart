// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCompany _$UpdateCompanyFromJson(Map<String, dynamic> json) =>
    UpdateCompany(
      address: json['address'] == null
          ? null
          : CompanyAddress.fromJson(json['address'] as Map<String, dynamic>),
      avatar: json['avatar'] as String?,
      categoryId: json['categoryId'] as String?,
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

Map<String, dynamic> _$UpdateCompanyToJson(UpdateCompany instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
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
