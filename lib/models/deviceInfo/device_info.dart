// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'device_info.g.dart';

@JsonSerializable(explicitToJson: true)
class DeviceInformation {
  String? android_notification_mode;
  String? gcm;
  String? device_type;
  String? device_token;
  String? ios_notification_mode;

  DeviceInformation({
    this.android_notification_mode,
    this.gcm,
    this.device_type,
    this.device_token,
    this.ios_notification_mode,
  });
  factory DeviceInformation.fromJson(Map<String, dynamic> json) =>
      _$DeviceInformationFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceInformationToJson(this);
}
