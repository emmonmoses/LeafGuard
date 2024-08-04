// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdministratorSearch _$AdministratorSearchFromJson(Map<String, dynamic> json) =>
    AdministratorSearch(
      status: json['status'] as int? ?? 1,
      page: json['page'] as int?,
      pages: json['pages'] as int?,
      pageSize: json['pageSize'] as int?,
      rows: json['rows'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Administrator.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdministratorSearchToJson(
        AdministratorSearch instance) =>
    <String, dynamic>{
      'status': instance.status,
      'page': instance.page,
      'pages': instance.pages,
      'pageSize': instance.pageSize,
      'rows': instance.rows,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
