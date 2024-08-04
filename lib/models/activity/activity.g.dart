// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      last_logout: DateTime.parse(json['last_logout'] as String),
      last_login: DateTime.parse(json['last_login'] as String),
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'last_logout': instance.last_logout.toIso8601String(),
      'last_login': instance.last_login.toIso8601String(),
    };
