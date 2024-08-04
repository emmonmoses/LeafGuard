// ignore_for_file: overridden_fields, annotate_overrides
// Project imports:
import 'package:leafguard/models/cancellation/cancellation.dart';
import 'package:leafguard/models/pagination/page_options.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'cancellation_search.g.dart';

@JsonSerializable(explicitToJson: true)
class CancellationRulesSearch extends Paginator {
  List<CancellationRules>? data;
  CancellationRulesSearch({
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

  factory CancellationRulesSearch.fromJson(Map<String, dynamic> json) =>
      _$CancellationRulesSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CancellationRulesSearchToJson(this);
}
