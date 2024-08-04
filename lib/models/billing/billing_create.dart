// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'billing_create.g.dart';

@JsonSerializable(explicitToJson: true)
class BillingCreate {
  String? billing_period;
  String? valid_from;
  String? valid_to;
  int? status;

  BillingCreate({
    this.billing_period,
    this.valid_from,
    this.valid_to,
    this.status,
  });

  factory BillingCreate.fromJson(Map<String, dynamic> json) =>
      _$BillingCreateFromJson(json);
  Map<String, dynamic> toJson() => _$BillingCreateToJson(this);
}
