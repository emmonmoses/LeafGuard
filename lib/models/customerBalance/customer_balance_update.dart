// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'customer_balance_update.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerBalanceUpdate {
  String? id;
  String? customerNumber;
  String? customerPhone;
  dynamic customerBalance;

  CustomerBalanceUpdate({
    required this.id,
    this.customerNumber,
    this.customerPhone,
    this.customerBalance,
  });

  factory CustomerBalanceUpdate.fromJson(Map<String, dynamic> json) =>
      _$CustomerBalanceUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerBalanceUpdateToJson(this);
}
