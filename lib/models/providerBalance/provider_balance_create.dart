// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'provider_balance_create.g.dart';

@JsonSerializable(explicitToJson: true)
class ProviderBalanceCreate {
  String? taskerId;
  double? taskerBalance;

  ProviderBalanceCreate({
    this.taskerId,
    this.taskerBalance,
  });

  factory ProviderBalanceCreate.fromJson(Map<String, dynamic> json) =>
      _$ProviderBalanceCreateFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderBalanceCreateToJson(this);
}
