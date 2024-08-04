import 'package:json_annotation/json_annotation.dart';

part "agent_commission.g.dart";

@JsonSerializable(explicitToJson: true)
class AgentCommission {
  String? rate;
  String? amount;

  AgentCommission({
    this.rate,
    this.amount,
  });

  factory AgentCommission.fromJson(Map<String, dynamic> json) =>
      _$AgentCommissionFromJson(json);
  Map<String, dynamic> toJson() => _$AgentCommissionToJson(this);
}
