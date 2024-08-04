// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

// Project imports:
part 'discount.g.dart';

@JsonSerializable(explicitToJson: true)
class Discount {
  String? id;
  String? createdAt;
  String? name;
  String? code;
  String? discount_type;
  dynamic rate;
  dynamic amount_percentage;
  dynamic amount;
  String? description;
  int? status;
  DateTime? expiry_date;
  DateTime? valid_from;

  Discount({
    this.id,
    this.createdAt,
    this.name,
    this.code,
    this.discount_type,
    this.rate,
    this.amount_percentage,
    this.amount,
    this.description,
    this.status,
    this.expiry_date,
    this.valid_from,
  });

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountToJson(this);
}
