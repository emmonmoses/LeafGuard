// ignore_for_file: overridden_fields, annotate_overrides
// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/pagination/page_options.dart';
import 'package:leafguard/models/transactions/transaction.dart';

part 'transaction_search.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionSearch extends Paginator {
  List<Transaction>? data;
  TransactionSearch({
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

  factory TransactionSearch.fromJson(Map<String, dynamic> json) =>
      _$TransactionSearchFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$TransactionSearchToJson(this);
}
