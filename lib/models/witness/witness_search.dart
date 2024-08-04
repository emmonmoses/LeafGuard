// ignore_for_file: overridden_fields, annotate_overrides
// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/pagination/page_options.dart';
import 'package:leafguard/models/witness/witnesses.dart';

part 'witness_search.g.dart';

@JsonSerializable(explicitToJson: true)
class WitnessSearch extends Paginator {
  List<Witnesses>? data;
  WitnessSearch({
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

  factory WitnessSearch.fromJson(Map<String, dynamic> json) =>
      _$WitnessSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$WitnessSearchToJson(this);
}
