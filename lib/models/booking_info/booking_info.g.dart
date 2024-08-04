// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingInformation _$BookingInformationFromJson(Map<String, dynamic> json) =>
    BookingInformation(
      work_type: json['work_type'] as String?,
      service_type: json['service_type'] as String?,
      instruction: json['instruction'] as String?,
      est_reach_date: json['est_reach_date'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      booking_date: json['booking_date'] as String?,
    );

Map<String, dynamic> _$BookingInformationToJson(BookingInformation instance) =>
    <String, dynamic>{
      'work_type': instance.work_type,
      'service_type': instance.service_type,
      'instruction': instance.instruction,
      'est_reach_date': instance.est_reach_date,
      'category': instance.category?.toJson(),
      'services': instance.services?.map((e) => e.toJson()).toList(),
      'booking_date': instance.booking_date,
    };
