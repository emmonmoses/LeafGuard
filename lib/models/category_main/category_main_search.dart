// ignore_for_file: overridden_fields, annotate_overrides
// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/category_main/category_main.dart';

// Project imports:
import 'package:leafguard/models/pagination/page_options.dart';

part 'category_main_search.g.dart';

@JsonSerializable(explicitToJson: true)
class MainCategorySearch extends Paginator {
  List<MainCategory>? data;
  MainCategorySearch({
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

  factory MainCategorySearch.fromJson(Map<String, dynamic> json) =>
      _$MainCategorySearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MainCategorySearchToJson(this);
}
