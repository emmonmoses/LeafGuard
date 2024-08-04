// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'question_create.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionCreate {
  int? question_status;
  String? question_tag;

  QuestionCreate({
    this.question_status,
    this.question_tag,
  });

  factory QuestionCreate.fromJson(Map<String, dynamic> json) =>
      _$QuestionCreateFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionCreateToJson(this);
}
