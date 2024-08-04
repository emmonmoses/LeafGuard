// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/hour/hour.dart';

part 'working_days.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkingDay {
  String? day;
  bool availability;
  WorkingHour? hour;

  WorkingDay({
    this.day,
    this.availability = false,
    this.hour,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) =>
      _$WorkingDayFromJson(json);
  Map<String, dynamic> toJson() => _$WorkingDayToJson(this);
}
