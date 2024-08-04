// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'experience.g.dart';

@JsonSerializable(explicitToJson: true)
class Experience {
  String? id;
  String? name;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Experience({
    this.id,
    this.name,
    this.status = 1,
    this.createdAt,
    this.updatedAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
