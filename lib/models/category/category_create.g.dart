// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryCreate _$CategoryCreateFromJson(Map<String, dynamic> json) =>
    CategoryCreate(
      name: json['name'] as String,
      maincategoryId: json['maincategoryId'] as String,
      description: json['description'] as String?,
      adminCommission: json['adminCommission'] as String?,
      discount: json['discount'] == null
          ? null
          : DiscountCatagory.fromJson(json['discount'] as Map<String, dynamic>),
      avatar: json['avatar'],
      status: json['status'] as int? ?? 0,
      tax: json['tax'] == null
          ? null
          : TaxCatagory.fromJson(json['tax'] as Map<String, dynamic>),
      price: json['price'] as String?,
    );

Map<String, dynamic> _$CategoryCreateToJson(CategoryCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'maincategoryId': instance.maincategoryId,
      'description': instance.description,
      'avatar': instance.avatar,
      'price': instance.price,
      'tax': instance.tax?.toJson(),
      'discount': instance.discount?.toJson(),
      'adminCommission': instance.adminCommission,
      'status': instance.status,
    };
