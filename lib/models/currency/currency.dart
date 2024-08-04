// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'currency.g.dart';

@JsonSerializable(explicitToJson: true)
class Currency {
  String? id;
  String? name;
  String? code;
  String? symbol;
  String? value;
  int? featured;
  int? status;
  int? default_currency;

  Currency({
    this.id,
    this.name,
    this.code,
    this.symbol,
    this.value,
    this.featured,
    this.status = 1,
    this.default_currency,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
