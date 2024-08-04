// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalogue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Catalogue _$CatalogueFromJson(Map<String, dynamic> json) => Catalogue(
      json['mainUrl'] as String,
      (json['thumbnailUrls'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CatalogueToJson(Catalogue instance) => <String, dynamic>{
      'mainUrl': instance.mainUrl,
      'thumbnailUrls': instance.thumbnailUrls,
    };
