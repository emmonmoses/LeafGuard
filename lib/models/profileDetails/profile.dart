// Package imports:

import 'package:json_annotation/json_annotation.dart';
part 'profile.g.dart';

@JsonSerializable()
class ProfileDetails {
  String? question;
  String? answer;

  ProfileDetails({
    this.question,
    this.answer,
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileDetailsToJson(this);
}
