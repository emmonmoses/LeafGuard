// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/ebirrInfo/service_params.dart';

part 'balance_recharge.g.dart';

@JsonSerializable(explicitToJson: true)
class BalanceRecharge {
  String schemaVersion;
  String requestId;
  String timestamp;
  String channelName;
  String serviceName;
  ServiceParams serviceParams;
  BalanceRecharge({
    this.schemaVersion = "1.0",
    this.requestId = "RjEV1zQ0lTbA4oe7g",
    this.timestamp = "RjEV1zQ0lTbA4oe7g",
    this.channelName = "WEB",
    this.serviceName = "API_PURCHASE",
    required this.serviceParams,
  });

  factory BalanceRecharge.fromJson(Map<String, dynamic> json) =>
      _$BalanceRechargeFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceRechargeToJson(this);
}
