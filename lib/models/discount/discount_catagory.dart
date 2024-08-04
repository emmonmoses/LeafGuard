// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'discount_catagory.g.dart';

@JsonSerializable(explicitToJson: true)
class DiscountCatagory {
  String? name;
  String? rate;

  DiscountCatagory({
    this.name,
    this.rate,
  });

  factory DiscountCatagory.fromJson(Map<String, dynamic> json) =>
      _$DiscountCatagoryFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountCatagoryToJson(this);
}
