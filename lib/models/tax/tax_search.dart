// ignore_for_file: overridden_fields, annotate_overrides
// Project imports:
import 'package:leafguard/models/pagination/page_options.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/tax/tax.dart';

part 'tax_search.g.dart';

@JsonSerializable(explicitToJson: true)
class TaxSearch extends Paginator {
  List<Tax>? data;
  TaxSearch({
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

  factory TaxSearch.fromJson(Map<String, dynamic> json) =>
      _$TaxSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TaxSearchToJson(this);
}
