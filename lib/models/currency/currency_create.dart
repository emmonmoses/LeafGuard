// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'currency_create.g.dart';

@JsonSerializable(explicitToJson: true)
class CurrencyCreate {
  String? currency_name;
  String? currency_code;
  String? currency_symbol;
  int? currency_value;
  int? currency_status;

  CurrencyCreate({
    this.currency_name,
    this.currency_code,
    this.currency_symbol,
    this.currency_value,
    this.currency_status,
  });

  factory CurrencyCreate.fromJson(Map<String, dynamic> json) =>
      _$CurrencyCreateFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyCreateToJson(this);
}
