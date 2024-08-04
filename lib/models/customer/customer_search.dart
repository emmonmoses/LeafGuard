// ignore_for_file: overridden_fields, annotate_overrides
// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:leafguard/models/pagination/page_options.dart';
import 'package:leafguard/models/customer/customer.dart';

part 'customer_search.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerSearch extends Paginator {
  List<Customer>? data;
  CustomerSearch({
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

  factory CustomerSearch.fromJson(Map<String, dynamic> json) =>
      _$CustomerSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CustomerSearchToJson(this);
}
