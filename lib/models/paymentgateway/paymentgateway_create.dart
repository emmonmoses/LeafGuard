// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/gatewaySetting/gatewaysetting.dart';

part 'paymentgateway_create.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentGatewayCreate {
  String? payment_gateway;
  String? gateway_alias;
  GatewaySetting? gateway_settings;
  int? status;

  PaymentGatewayCreate({
    this.payment_gateway,
    this.gateway_alias,
    this.gateway_settings,
    this.status,
  });

  factory PaymentGatewayCreate.fromJson(Map<String, dynamic> json) =>
      _$PaymentGatewayCreateFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentGatewayCreateToJson(this);
}
