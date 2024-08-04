// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'gatewaysetting.g.dart';

@JsonSerializable(explicitToJson: true)
class GatewaySetting {
  String? redirect_uri;
  String? publishable_key;
  String? secret_key;
  String? mode;
  String? client_key;
  String? sandbox_secret_key;
  String? live_secret_key;

  GatewaySetting({
    this.redirect_uri,
    this.publishable_key,
    this.secret_key,
    this.mode,
    this.client_key,
    this.sandbox_secret_key,
    this.live_secret_key,
  });

  factory GatewaySetting.fromJson(Map<String, dynamic> json) =>
      _$GatewaySettingFromJson(json);
  Map<String, dynamic> toJson() => _$GatewaySettingToJson(this);
}
