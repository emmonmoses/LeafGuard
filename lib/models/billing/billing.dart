// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'billing.g.dart';

@JsonSerializable(explicitToJson: true)
class Billing {
  String? id;
  String? billingcycyle;
  DateTime? start_date;
  DateTime? end_date;
  String? createdAt;
  String? updatedAt;
  int? status;

  Billing({
    this.id,
    this.billingcycyle,
    this.start_date,
    this.end_date,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory Billing.fromJson(Map<String, dynamic> json) =>
      _$BillingFromJson(json);
  Map<String, dynamic> toJson() => _$BillingToJson(this);
}
