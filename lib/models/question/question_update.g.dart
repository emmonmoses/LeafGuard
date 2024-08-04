// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionUpdate _$QuestionUpdateFromJson(Map<String, dynamic> json) =>
    QuestionUpdate(
      id: json['id'] as String,
      question_status: json['question_status'] as int?,
      question_tag: json['question_tag'] as String?,
    );

Map<String, dynamic> _$QuestionUpdateToJson(QuestionUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question_status': instance.question_status,
      'question_tag': instance.question_tag,
    };
