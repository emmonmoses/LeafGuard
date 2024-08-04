// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable(explicitToJson: true)
class Activity {
  DateTime last_logout;
  DateTime last_login;
  // DateTime? createdAt;
  // DateTime? updatedtedAt;

  Activity({
    required this.last_logout,
    required this.last_login,
    // this.createdAt,
    // this.updatedtedAt,
  });
  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
