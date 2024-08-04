// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_main_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainCategoryUpdate _$MainCategoryUpdateFromJson(Map<String, dynamic> json) =>
    MainCategoryUpdate(
      id: json['id'] as String,
      name: json['name'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$MainCategoryUpdateToJson(MainCategoryUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
    };
