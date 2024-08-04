// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceUpdate _$ServiceUpdateFromJson(Map<String, dynamic> json) =>
    ServiceUpdate(
      id: json['id'] as String,
      taskerId: json['taskerId'] as String?,
      categoryId: (json['categoryId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$ServiceUpdateToJson(ServiceUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'taskerId': instance.taskerId,
      'categoryId': instance.categoryId,
      'description': instance.description,
      'createdBy': instance.createdBy,
    };
