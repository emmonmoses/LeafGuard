// ignore_for_file: overridden_fields, annotate_overrides
// Project imports:
import 'package:leafguard/models/pagination/page_options.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/paymentgateway/paymentgateway.dart';

part 'paymentgateway_search.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentGatewaySearch extends Paginator {
  List<PaymentGateway>? data;
  PaymentGatewaySearch({
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

  factory PaymentGatewaySearch.fromJson(Map<String, dynamic> json) =>
      _$PaymentGatewaySearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PaymentGatewaySearchToJson(this);
}
