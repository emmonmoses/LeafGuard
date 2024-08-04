// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storageResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageResponse _$StorageResponseFromJson(Map<String, dynamic> json) =>
    StorageResponse(
      json['id'] as String,
      json['name'] as String,
      json['fileKey'] as String,
      json['fileExtension'] as String,
      json['mimeType'] as String,
      Catalogue.fromJson(json['catalogueUrl'] as Map<String, dynamic>),
      DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$StorageResponseToJson(StorageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fileKey': instance.fileKey,
      'fileExtension': instance.fileExtension,
      'mimeType': instance.mimeType,
      'catalogueUrl': instance.catalogueUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };
