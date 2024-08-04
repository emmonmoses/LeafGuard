// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInformation _$DeviceInformationFromJson(Map<String, dynamic> json) =>
    DeviceInformation(
      android_notification_mode: json['android_notification_mode'] as String?,
      gcm: json['gcm'] as String?,
      device_type: json['device_type'] as String?,
      device_token: json['device_token'] as String?,
      ios_notification_mode: json['ios_notification_mode'] as String?,
    );

Map<String, dynamic> _$DeviceInformationToJson(DeviceInformation instance) =>
    <String, dynamic>{
      'android_notification_mode': instance.android_notification_mode,
      'gcm': instance.gcm,
      'device_type': instance.device_type,
      'device_token': instance.device_token,
      'ios_notification_mode': instance.ios_notification_mode,
    };
