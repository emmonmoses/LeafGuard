// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceUpdate _$ExperienceUpdateFromJson(Map<String, dynamic> json) =>
    ExperienceUpdate(
      id: json['id'] as String,
      experience_tag: json['experience_tag'] as String,
      experience_status: json['experience_status'] as int?,
    );

Map<String, dynamic> _$ExperienceUpdateToJson(ExperienceUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'experience_tag': instance.experience_tag,
      'experience_status': instance.experience_status,
    };
