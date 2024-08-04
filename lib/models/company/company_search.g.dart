// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanySearch _$CompanySearchFromJson(Map<String, dynamic> json) =>
    CompanySearch(
      page: json['page'] as int?,
      pages: json['pages'] as int?,
      pageSize: json['pageSize'] as int?,
      rows: json['rows'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Company.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanySearchToJson(CompanySearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pages': instance.pages,
      'pageSize': instance.pageSize,
      'rows': instance.rows,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
