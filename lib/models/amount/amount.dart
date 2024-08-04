// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'amount.g.dart';

@JsonSerializable(explicitToJson: true)
class Amount {
  int? task_cost;
  int? service_tax;
  int? service_discount;
  double? admin_commission;
  int? total; // amount
  int? grand_total; // totalAmount
  // ----------------------------------------------------------------
  int? minimum_cost;
  int? extra_amount;
  int? balance_amount;
  int? worked_hours_cost;

  Amount({
    this.task_cost,
    this.service_tax,
    this.service_discount,
    this.admin_commission,
    this.total,
    this.grand_total,
    // ----------------------------------------------------------------
    this.minimum_cost,
    this.extra_amount,
    this.balance_amount,
    this.worked_hours_cost,
  });
  factory Amount.fromJson(Map<String, dynamic> json) => _$AmountFromJson(json);
  Map<String, dynamic> toJson() => _$AmountToJson(this);
}
