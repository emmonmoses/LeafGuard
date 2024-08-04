// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'experience_update.g.dart';

@JsonSerializable(explicitToJson: true)
class ExperienceUpdate {
  String id;
  String experience_tag;
  int? experience_status;

  ExperienceUpdate({
    required this.id,
    required this.experience_tag,
    this.experience_status,
  });

  factory ExperienceUpdate.fromJson(Map<String, dynamic> json) =>
      _$ExperienceUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceUpdateToJson(this);
}
