// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skills.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceProviderSkills _$ServiceProviderSkillsFromJson(
        Map<String, dynamic> json) =>
    ServiceProviderSkills(
      categoryid: json['categoryid'] == null
          ? null
          : Category.fromJson(json['categoryid'] as Map<String, dynamic>),
      childid: json['childid'] == null
          ? null
          : Service.fromJson(json['childid'] as Map<String, dynamic>),
      quick_pitch: json['quick_pitch'] as String?,
      hour_rate: json['hour_rate'],
      experience: json['experience'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$ServiceProviderSkillsToJson(
        ServiceProviderSkills instance) =>
    <String, dynamic>{
      'categoryid': instance.categoryid?.toJson(),
      'childid': instance.childid?.toJson(),
      'hour_rate': instance.hour_rate,
      'experience': instance.experience,
      'quick_pitch': instance.quick_pitch,
      'status': instance.status,
    };
