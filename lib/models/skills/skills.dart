// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/service/service.dart';

part 'skills.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceProviderSkills {
  Category? categoryid;
  Service? childid;
  dynamic hour_rate;
  String? experience;
  String? quick_pitch;
  int? status;

  ServiceProviderSkills({
    this.categoryid,
    this.childid,
    this.quick_pitch,
    this.hour_rate,
    this.experience,
    this.status,
  });
  factory ServiceProviderSkills.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderSkillsFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceProviderSkillsToJson(this);
}
