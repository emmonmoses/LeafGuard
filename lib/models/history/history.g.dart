// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingHistory _$BookingHistoryFromJson(Map<String, dynamic> json) =>
    BookingHistory(
      job_booking_time: json['job_booking_time'] as String?,
      job_cancellation_time: json['job_cancellation_time'] as String?,
      job_cancellation_reason: json['job_cancellation_reason'] as String?,
      provider_assigned: json['provider_assigned'] as String?,
      job_started_time: json['job_started_time'] as int?,
      job_completed_time: json['job_completed_time'] as int?,
      provider_start_off_time: json['provider_start_off_time'] as String?,
      location_arrived_time: json['location_arrived_time'] as String?,
    );

Map<String, dynamic> _$BookingHistoryToJson(BookingHistory instance) =>
    <String, dynamic>{
      'job_booking_time': instance.job_booking_time,
      'job_cancellation_time': instance.job_cancellation_time,
      'job_cancellation_reason': instance.job_cancellation_reason,
      'provider_assigned': instance.provider_assigned,
      'job_started_time': instance.job_started_time,
      'job_completed_time': instance.job_completed_time,
      'provider_start_off_time': instance.provider_start_off_time,
      'location_arrived_time': instance.location_arrived_time,
    };
