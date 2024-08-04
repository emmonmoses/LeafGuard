// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'provider_location.g.dart';

@JsonSerializable()
class ProviderLocation {
  dynamic provider_lng;
  dynamic provider_lat;

  ProviderLocation(this.provider_lng, this.provider_lat);

  factory ProviderLocation.fromJson(Map<String, dynamic> json) =>
      _$ProviderLocationFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderLocationToJson(this);
}
