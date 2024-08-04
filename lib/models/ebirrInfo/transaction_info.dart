// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'transaction_info.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionInfo {
  String amount;
  String currency;
  String description;
  String referenceId;
  String invoiceId;

  TransactionInfo({
    required this.amount,
    required this.currency,
    required this.description,
    required this.referenceId,
    required this.invoiceId,
  });

  factory TransactionInfo.fromJson(Map<String, dynamic> json) =>
      _$TransactionInfoFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionInfoToJson(this);
}
