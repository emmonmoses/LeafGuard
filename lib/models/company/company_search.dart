import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/company/company.dart';
import 'package:leafguard/models/pagination/page_options.dart';
part 'company_search.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanySearch extends Paginator {
  List<Company>? data;

  CompanySearch({
    int? page,
    int? pages,
    int? pageSize,
    int? rows,
    this.data,
  }) : super(
          page: page,
          pages: pages,
          pageSize: pageSize,
          rows: rows,
        );

  factory CompanySearch.fromJson(Map<String, dynamic> json) =>
      _$CompanySearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CompanySearchToJson(this);
}
