// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingHistory {
  String? job_booking_time;
  String? job_cancellation_time;
  String? job_cancellation_reason;
  String? provider_assigned;
  int? job_started_time;
  int? job_completed_time;
  String? provider_start_off_time;
  String? location_arrived_time;

  BookingHistory({
    this.job_booking_time,
    this.job_cancellation_time,
    this.job_cancellation_reason,
    this.provider_assigned,
    this.job_started_time,
    this.job_completed_time,
    this.provider_start_off_time,
    this.location_arrived_time,
  });
  factory BookingHistory.fromJson(Map<String, dynamic> json) =>
      _$BookingHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$BookingHistoryToJson(this);
}
