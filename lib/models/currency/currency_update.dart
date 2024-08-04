// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'currency_update.g.dart';

@JsonSerializable(explicitToJson: true)
class CurrencyUpdate {
  String id;
  String currency_name;
  String? currency_code;
  String? currency_symbol;
  int? currency_value;
  int? currency_status;

  CurrencyUpdate({
    required this.id,
    required this.currency_name,
    this.currency_code,
    this.currency_symbol,
    this.currency_value,
    this.currency_status,
  });

  factory CurrencyUpdate.fromJson(Map<String, dynamic> json) =>
      _$CurrencyUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyUpdateToJson(this);
}
