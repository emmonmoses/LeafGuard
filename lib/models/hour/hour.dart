// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'hour.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkingHour {
  bool morning;
  bool afternoon;
  bool evening;

  WorkingHour({
    this.morning = true,
    this.afternoon = false,
    this.evening = false,
  });

  factory WorkingHour.fromJson(Map<String, dynamic> json) =>
      _$WorkingHourFromJson(json);
  Map<String, dynamic> toJson() => _$WorkingHourToJson(this);
}
