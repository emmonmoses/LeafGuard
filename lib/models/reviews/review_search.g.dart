// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewSearch _$ReviewSearchFromJson(Map<String, dynamic> json) => ReviewSearch(
      status: json['status'] as int? ?? 1,
      page: json['page'] as int?,
      pages: json['pages'] as int?,
      pageSize: json['pageSize'] as int?,
      rows: json['rows'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Reviews.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewSearchToJson(ReviewSearch instance) =>
    <String, dynamic>{
      'status': instance.status,
      'page': instance.page,
      'pages': instance.pages,
      'pageSize': instance.pageSize,
      'rows': instance.rows,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
