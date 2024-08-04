// ignore_for_file: overridden_fields, annotate_overrides
// Project imports:
import 'package:leafguard/models/pagination/page_options.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/question/question.dart';

part 'question_search.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionSearch extends Paginator {
  List<Question>? data;
  QuestionSearch({
    int status = 1,
    int? page,
    int? pages,
    int? pageSize,
    int? rows,
    this.data,
  }) : super(
          status: status,
          page: page,
          pages: pages,
          pageSize: pageSize,
          rows: rows,
        );

  factory QuestionSearch.fromJson(Map<String, dynamic> json) =>
      _$QuestionSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$QuestionSearchToJson(this);
}
