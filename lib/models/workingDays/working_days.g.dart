// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_days.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkingDay _$WorkingDayFromJson(Map<String, dynamic> json) => WorkingDay(
      day: json['day'] as String?,
      availability: json['availability'] as bool? ?? false,
      hour: json['hour'] == null
          ? null
          : WorkingHour.fromJson(json['hour'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkingDayToJson(WorkingDay instance) =>
    <String, dynamic>{
      'day': instance.day,
      'availability': instance.availability,
      'hour': instance.hour?.toJson(),
    };
