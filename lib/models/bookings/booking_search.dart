// ignore_for_file: overridden_fields, annotate_overrides
// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/bookings/booking.dart';

// Project imports:
import 'package:leafguard/models/pagination/page_options.dart';

part 'booking_search.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingSearch extends Paginator {
  List<Booking>? data;
  BookingSearch({
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

  factory BookingSearch.fromJson(Map<String, dynamic> json) =>
      _$BookingSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$BookingSearchToJson(this);
}
