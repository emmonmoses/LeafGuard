// ignore_for_file: overridden_fields, annotate_overrides
// Project imports:
import 'package:leafguard/models/discount/discount.dart';
import 'package:leafguard/models/pagination/page_options.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'discount_search.g.dart';

@JsonSerializable(explicitToJson: true)
class DiscountSearch extends Paginator {
  List<Discount>? data;
  DiscountSearch({
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

  factory DiscountSearch.fromJson(Map<String, dynamic> json) =>
      _$DiscountSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DiscountSearchToJson(this);
}
