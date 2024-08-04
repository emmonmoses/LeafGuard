// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'question_update.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionUpdate {
  String id;
  int? question_status;
  String? question_tag;

  QuestionUpdate({
    required this.id,
    this.question_status,
    this.question_tag,
  });

  factory QuestionUpdate.fromJson(Map<String, dynamic> json) =>
      _$QuestionUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionUpdateToJson(this);
}
