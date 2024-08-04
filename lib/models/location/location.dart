// Package imports:

import 'package:json_annotation/json_annotation.dart';
part 'location.g.dart';

@JsonSerializable()
class Location {
  double? lng;
  double? log;
  double? lat;

  Location({
    this.lng = 38.763611,
    this.log = 38.763611,
    this.lat = 9.005401,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
