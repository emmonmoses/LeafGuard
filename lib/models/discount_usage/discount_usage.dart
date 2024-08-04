// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'discount_usage.g.dart';

@JsonSerializable(explicitToJson: true)
class DiscountUsage {
  int? total_coupons;
  int? per_user;

  DiscountUsage({
    this.total_coupons,
    this.per_user,
  });

  factory DiscountUsage.fromJson(Map<String, dynamic> json) =>
      _$DiscountUsageFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountUsageToJson(this);
}
