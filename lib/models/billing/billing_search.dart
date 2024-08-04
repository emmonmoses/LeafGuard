// ignore_for_file: overridden_fields, annotate_overrides
// Project imports:
import 'package:leafguard/models/billing/billing.dart';
import 'package:leafguard/models/pagination/page_options.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'billing_search.g.dart';

@JsonSerializable(explicitToJson: true)
class BillingSearch extends Paginator {
  List<Billing>? data;
  BillingSearch({
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

  factory BillingSearch.fromJson(Map<String, dynamic> json) =>
      _$BillingSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$BillingSearchToJson(this);
}
