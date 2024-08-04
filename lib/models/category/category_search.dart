// ignore_for_file: overridden_fields, annotate_overrides
// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:leafguard/models/pagination/page_options.dart';
import 'package:leafguard/models/category/category.dart';

part 'category_search.g.dart';

@JsonSerializable(explicitToJson: true)
class CategorySearch extends Paginator {
  List<Category>? data;
  CategorySearch({
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

  factory CategorySearch.fromJson(Map<String, dynamic> json) =>
      _$CategorySearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CategorySearchToJson(this);
}
