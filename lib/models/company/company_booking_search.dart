import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/company/company_booking.dart';
import 'package:leafguard/models/pagination/page_options.dart';
part 'company_booking_search.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyBookingSearch extends Paginator {
  List<CompanyBooking>? data;

  CompanyBookingSearch({
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

  factory CompanyBookingSearch.fromJson(Map<String, dynamic> json) =>
      _$CompanyBookingSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CompanyBookingSearchToJson(this);
}
