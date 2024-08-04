// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seo _$SeoFromJson(Map<String, dynamic> json) => Seo(
      keyword: json['keyword'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$SeoToJson(Seo instance) => <String, dynamic>{
      'keyword': instance.keyword,
      'title': instance.title,
      'description': instance.description,
    };
