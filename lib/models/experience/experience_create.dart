// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'experience_create.g.dart';

@JsonSerializable(explicitToJson: true)
class ExperienceCreate {
  String? experience_tag;
  int? experience_status;

  ExperienceCreate({
    this.experience_tag,
    this.experience_status,
  });

  factory ExperienceCreate.fromJson(Map<String, dynamic> json) =>
      _$ExperienceCreateFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceCreateToJson(this);
}
