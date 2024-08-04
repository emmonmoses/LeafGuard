// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'tax_create.g.dart';

@JsonSerializable(explicitToJson: true)
class TaxCreate {
  String? name;
  int? rate;
  String? description;
  int? status;

  TaxCreate({
    this.name,
    this.rate,
    this.description,
    this.status = 1,
  });

  factory TaxCreate.fromJson(Map<String, dynamic> json) =>
      _$TaxCreateFromJson(json);
  Map<String, dynamic> toJson() => _$TaxCreateToJson(this);
}
