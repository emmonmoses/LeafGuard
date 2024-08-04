// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'customer_balance_create.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerBalanceCreate {
  String? customerId;
  double? customerBalance;

  CustomerBalanceCreate({
    this.customerId,
    this.customerBalance,
  });

  factory CustomerBalanceCreate.fromJson(Map<String, dynamic> json) =>
      _$CustomerBalanceCreateFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerBalanceCreateToJson(this);
}
