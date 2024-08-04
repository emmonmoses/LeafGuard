// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'billing_update.g.dart';

@JsonSerializable(explicitToJson: true)
class BillingUpdate {
  String id;
  String? billing_period;
  String? valid_from;
  String? valid_to;
  int? status;

  BillingUpdate({
    required this.id,
    this.billing_period,
    this.valid_from,
    this.valid_to,
    this.status,
  });

  factory BillingUpdate.fromJson(Map<String, dynamic> json) =>
      _$BillingUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$BillingUpdateToJson(this);
}
