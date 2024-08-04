// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceCreate _$ExperienceCreateFromJson(Map<String, dynamic> json) =>
    ExperienceCreate(
      experience_tag: json['experience_tag'] as String?,
      experience_status: json['experience_status'] as int?,
    );

Map<String, dynamic> _$ExperienceCreateToJson(ExperienceCreate instance) =>
    <String, dynamic>{
      'experience_tag': instance.experience_tag,
      'experience_status': instance.experience_status,
    };
