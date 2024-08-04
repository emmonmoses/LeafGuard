// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'discount_create.g.dart';

@JsonSerializable(explicitToJson: true)
class DiscountCreate {
  String? name;
  String? code;
  String? discount_type;
  int? rate;
  String? description;
  dynamic status;
  // String? amount_percentage;
  String? valid_from;
  String? expiry_date;
  // CouponUsage? usage;

  DiscountCreate({
    this.name,
    this.rate,
    this.description,
    this.status = 1,
    this.code,
    this.discount_type,
    // this.amount_percentage,
    this.valid_from,
    this.expiry_date,
    // this.usage,
  });

  factory DiscountCreate.fromJson(Map<String, dynamic> json) =>
      _$DiscountCreateFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountCreateToJson(this);
}
