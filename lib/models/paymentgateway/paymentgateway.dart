// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/gatewaySetting/gatewaysetting.dart';

// Project imports:

part 'paymentgateway.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentGateway {
  String? id;
  String? gateway_name;
  String? alias;
  DateTime? createdAt;
  String? updatedAt;
  int? status;
  GatewaySetting? settings;

  PaymentGateway({
    this.id,
    this.gateway_name,
    this.alias,
    this.createdAt,
    this.updatedAt,
    this.status = 1,
    this.settings,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) =>
      _$PaymentGatewayFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentGatewayToJson(this);
}
