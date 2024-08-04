// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCreate _$ServiceCreateFromJson(Map<String, dynamic> json) =>
    ServiceCreate(
      taskerId: json['taskerId'] as String?,
      categoryId: (json['categoryId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$ServiceCreateToJson(ServiceCreate instance) =>
    <String, dynamic>{
      'taskerId': instance.taskerId,
      'categoryId': instance.categoryId,
      'description': instance.description,
      'createdBy': instance.createdBy,
    };
