import 'package:json_annotation/json_annotation.dart';

part "admin_commission.g.dart";

@JsonSerializable(explicitToJson: true)
class AdminCommission {
  String? rate;
  String? amount;

  AdminCommission({
    this.rate,
    this.amount,
  });

  factory AdminCommission.fromJson(Map<String, dynamic> json) =>
      _$AdminCommissionFromJson(json);
  Map<String, dynamic> toJson() => _$AdminCommissionToJson(this);
}
