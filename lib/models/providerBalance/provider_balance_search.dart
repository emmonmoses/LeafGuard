// ignore_for_file: overridden_fields, annotate_overrides
// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/providerBalance/provider.dart';
import 'package:leafguard/models/pagination/page_options.dart';

part 'provider_balance_search.g.dart';

@JsonSerializable(explicitToJson: true)
class ProviderBalanceSearch extends Paginator {
  List<ProviderBalance>? data;
  ProviderBalanceSearch({
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

  factory ProviderBalanceSearch.fromJson(Map<String, dynamic> json) =>
      _$ProviderBalanceSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProviderBalanceSearchToJson(this);
}
