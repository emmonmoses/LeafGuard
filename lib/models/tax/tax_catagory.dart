// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'tax_catagory.g.dart';

@JsonSerializable(explicitToJson: true)
class TaxCatagory {
  String? name;
  bool type;
  String? rate;

  TaxCatagory({
    this.name = "VAT",
    this.rate,
    this.type = true,
  });

  factory TaxCatagory.fromJson(Map<String, dynamic> json) =>
      _$TaxCatagoryFromJson(json);
  Map<String, dynamic> toJson() => _$TaxCatagoryToJson(this);
}
