// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkingHour _$WorkingHourFromJson(Map<String, dynamic> json) => WorkingHour(
      morning: json['morning'] as bool? ?? true,
      afternoon: json['afternoon'] as bool? ?? false,
      evening: json['evening'] as bool? ?? false,
    );

Map<String, dynamic> _$WorkingHourToJson(WorkingHour instance) =>
    <String, dynamic>{
      'morning': instance.morning,
      'afternoon': instance.afternoon,
      'evening': instance.evening,
    };
