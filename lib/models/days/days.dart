// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'days.g.dart';

@JsonSerializable(explicitToJson: true)
class Days {
  String? day;
  bool? availability;

  Days({
    this.day,
    this.availability,
  });

  factory Days.fromJson(Map<String, dynamic> json) => _$DaysFromJson(json);
  Map<String, dynamic> toJson() => _$DaysToJson(this);
}
