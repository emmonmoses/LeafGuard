// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/customer/customer.dart';

part 'customer.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerBalance {
  String? id;
  String? customerId;
  double? customerBalance;
  Customer? customer;
  DateTime? transactionDate;
  String? transactionId;

  CustomerBalance({
    this.id,
    this.customerId,
    this.customerBalance,
    this.customer,
    this.transactionDate,
    this.transactionId,
  });

  factory CustomerBalance.fromJson(Map<String, dynamic> json) =>
      _$CustomerBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerBalanceToJson(this);
}
