// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryUpdate _$CategoryUpdateFromJson(Map<String, dynamic> json) =>
    CategoryUpdate(
      id: json['id'] as String?,
      tax: json['tax'] == null
          ? null
          : TaxCategoryUpdate.fromJson(json['tax'] as Map<String, dynamic>),
      discount: json['discount'] == null
          ? null
          : DiscountCategoryUpdate.fromJson(
              json['discount'] as Map<String, dynamic>),
      maincategoryId: json['maincategoryId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      avatar: json['avatar'] as String?,
      price: json['price'] as String?,
      adminCommission: json['adminCommission'] as String?,
      agentCommission: json['agentCommission'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$CategoryUpdateToJson(CategoryUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tax': instance.tax?.toJson(),
      'discount': instance.discount?.toJson(),
      'maincategoryId': instance.maincategoryId,
      'name': instance.name,
      'description': instance.description,
      'avatar': instance.avatar,
      'price': instance.price,
      'adminCommission': instance.adminCommission,
      'agentCommission': instance.agentCommission,
      'status': instance.status,
    };
