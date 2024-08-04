// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_booking_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyBookingSearch _$CompanyBookingSearchFromJson(
        Map<String, dynamic> json) =>
    CompanyBookingSearch(
      page: json['page'] as int?,
      pages: json['pages'] as int?,
      pageSize: json['pageSize'] as int?,
      rows: json['rows'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CompanyBooking.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyBookingSearchToJson(
        CompanyBookingSearch instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pages': instance.pages,
      'pageSize': instance.pageSize,
      'rows': instance.rows,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
