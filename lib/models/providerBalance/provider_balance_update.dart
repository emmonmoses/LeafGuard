// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'provider_balance_update.g.dart';

@JsonSerializable(explicitToJson: true)
class ProviderBalanceUpdate {
  String? id;
  String? taskerNumber;
  String? taskerPhone;
  dynamic taskerBalance;

  ProviderBalanceUpdate({
    required this.id,
    this.taskerNumber,
    this.taskerPhone,
    this.taskerBalance,
  });

  factory ProviderBalanceUpdate.fromJson(Map<String, dynamic> json) =>
      _$ProviderBalanceUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderBalanceUpdateToJson(this);
}
