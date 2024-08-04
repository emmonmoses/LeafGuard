// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/provider/provider.dart';

part 'provider.g.dart';

@JsonSerializable(explicitToJson: true)
class ProviderBalance {
  String? id;
  String? taskerId;
  double? taskerBalance;
  ServiceProvider? tasker;
  DateTime? transactionDate;
  String? transactionId;

  ProviderBalance({
    this.id,
    this.taskerId,
    this.taskerBalance,
    this.tasker,
    this.transactionDate,
    this.transactionId,
  });

  factory ProviderBalance.fromJson(Map<String, dynamic> json) =>
      _$ProviderBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderBalanceToJson(this);
}
