// ignore_for_file: overridden_fields, annotate_overrides
// Project imports:
import 'package:leafguard/models/administrator/admin.dart';
import 'package:leafguard/models/pagination/page_options.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'admin_search.g.dart';

@JsonSerializable(explicitToJson: true)
class AdministratorSearch extends Paginator {
  List<Administrator>? data;
  AdministratorSearch({
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

  factory AdministratorSearch.fromJson(Map<String, dynamic> json) =>
      _$AdministratorSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AdministratorSearchToJson(this);
}
