// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  String? id;
  String? question;
  int? status;
  // DateTime? createdAt;
  // DateTime? updatedAt;

  Question({
    this.id,
    this.question,
    this.status = 1,
    // this.createdAt,
    // this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
