// ignore_for_file: overridden_fields, annotate_overrides
// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:leafguard/models/pagination/page_options.dart';
import 'package:leafguard/models/service/service.dart';

part 'service_search.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceSearch extends Paginator {
  List<Service>? data;
  ServiceSearch({
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

  factory ServiceSearch.fromJson(Map<String, dynamic> json) =>
      _$ServiceSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ServiceSearchToJson(this);
}
