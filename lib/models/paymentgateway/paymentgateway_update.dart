// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/gatewaySetting/gatewaysetting.dart';

part 'paymentgateway_update.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentGatewayUpdate {
  String? id;
  String? payment_gateway;
  String? gateway_alias;
  GatewaySetting? gateway_settings;
  int? status;

  PaymentGatewayUpdate({
    this.id,
    this.payment_gateway,
    this.gateway_alias,
    this.gateway_settings,
    this.status,
  });

  factory PaymentGatewayUpdate.fromJson(Map<String, dynamic> json) =>
      _$PaymentGatewayUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentGatewayUpdateToJson(this);
}
