// ignore_for_file: overridden_fields, annotate_overrides
// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:leafguard/models/pagination/page_options.dart';
import 'package:leafguard/models/provider/provider.dart';

part 'provider_search.g.dart';

@JsonSerializable(explicitToJson: true)
class ProviderSearch extends Paginator {
  List<ServiceProvider>? data;
  ProviderSearch({
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

  factory ProviderSearch.fromJson(Map<String, dynamic> json) =>
      _$ProviderSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProviderSearchToJson(this);
}
