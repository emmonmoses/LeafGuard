// ignore_for_file: overridden_fields, annotate_overrides
// Project imports:
import 'package:leafguard/models/experience/experience.dart';
import 'package:leafguard/models/pagination/page_options.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'experience_search.g.dart';

@JsonSerializable(explicitToJson: true)
class ExperienceSearch extends Paginator {
  List<Experience>? data;
  ExperienceSearch({
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

  factory ExperienceSearch.fromJson(Map<String, dynamic> json) =>
      _$ExperienceSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ExperienceSearchToJson(this);
}
