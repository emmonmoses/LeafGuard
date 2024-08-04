// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String?,
      tax: json['tax'] == null
          ? null
          : Tax.fromJson(json['tax'] as Map<String, dynamic>),
      discount: json['discount'] == null
          ? null
          : Discount.fromJson(json['discount'] as Map<String, dynamic>),
      maincategoryId: json['maincategoryId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      avatar: json['avatar'] as String?,
      price: json['price'] as String?,
      adminCommission: json['adminCommission'] as String?,
      agentCommission: json['agentCommission'] as String?,
      status: json['status'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      maincategory: json['maincategory'] == null
          ? null
          : MainCategory.fromJson(json['maincategory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
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
      'createdAt': instance.createdAt?.toIso8601String(),
      'maincategory': instance.maincategory?.toJson(),
    };
