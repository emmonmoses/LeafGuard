// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionCreate _$QuestionCreateFromJson(Map<String, dynamic> json) =>
    QuestionCreate(
      question_status: json['question_status'] as int?,
      question_tag: json['question_tag'] as String?,
    );

Map<String, dynamic> _$QuestionCreateToJson(QuestionCreate instance) =>
    <String, dynamic>{
      'question_status': instance.question_status,
      'question_tag': instance.question_tag,
    };
