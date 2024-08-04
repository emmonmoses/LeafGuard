// ignore_for_file: overridden_fields, annotate_overrides
// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/customerBalance/customer.dart';
import 'package:leafguard/models/pagination/page_options.dart';

part 'customer_balance_search.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerBalanceSearch extends Paginator {
  List<CustomerBalance>? data;
  CustomerBalanceSearch({
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

  factory CustomerBalanceSearch.fromJson(Map<String, dynamic> json) =>
      _$CustomerBalanceSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CustomerBalanceSearchToJson(this);
}
