// ignore_for_file: overridden_fields, annotate_overrides
// Project imports:
import 'package:leafguard/models/currency/currency.dart';
import 'package:leafguard/models/pagination/page_options.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'currency_search.g.dart';

@JsonSerializable(explicitToJson: true)
class CurrencySearch extends Paginator {
  List<Currency>? data;
  CurrencySearch({
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

  factory CurrencySearch.fromJson(Map<String, dynamic> json) =>
      _$CurrencySearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CurrencySearchToJson(this);
}
