// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'discount_update.g.dart';

@JsonSerializable(explicitToJson: true)
class DiscountUpdate {
  String id;
  String? name;
  String? code;
  String? discount_type;
  String? description;
  String? rate;
  String? amount_percentage;
  String? valid_from;
  String? expiry_date;
  int? status;
  // DiscountUsage? usage;

  DiscountUpdate({
    required this.id,
    this.name,
    this.code,
    this.discount_type,
    this.description,
    this.rate,
    this.amount_percentage,
    this.valid_from,
    this.expiry_date,
    this.status,
    // this.usage,
  });

  factory DiscountUpdate.fromJson(Map<String, dynamic> json) =>
      _$DiscountUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountUpdateToJson(this);
}
