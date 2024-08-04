// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paginator _$PaginatorFromJson(Map<String, dynamic> json) => Paginator(
      status: json['status'] as int? ?? 1,
      page: json['page'] as int?,
      pages: json['pages'] as int?,
      pageSize: json['pageSize'] as int?,
      rows: json['rows'] as int?,
    );

Map<String, dynamic> _$PaginatorToJson(Paginator instance) => <String, dynamic>{
      'status': instance.status,
      'page': instance.page,
      'pages': instance.pages,
      'pageSize': instance.pageSize,
      'rows': instance.rows,
    };
