// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/commission/commission.dart';
import 'package:leafguard/models/discount/discount.dart';
import 'package:leafguard/models/service/service.dart';
import 'package:leafguard/models/provider/provider.dart';
import 'package:leafguard/models/tax/tax.dart';
import 'package:leafguard/models/customer/customer.dart';

part 'transaction.g.dart';

@JsonSerializable(explicitToJson: true)
class Transaction {
  Tax? tax;
  Discount? discount;
  Commission? adminCommission;
  Commission? agentCommission;
  Commission? taskerCommission;
  Category? category;
  Service? service;
  Customer? customer;
  ServiceProvider? tasker;
  DateTime? transactionDate;
  String? id;
  String? taskerId;
  String? bookingId;
  String? bookingRef;
  String? customerId;
  String? createdBy;
  String? transactionRef;
  String? total;
  String? price;
  String? totalHoursWorked;
  String? basePrice;

  Transaction({
    this.tax,
    this.discount,
    this.adminCommission,
    this.agentCommission,
    this.taskerCommission,
    this.category,
    this.service,
    this.customer,
    this.tasker,
    this.transactionDate,
    this.id,
    this.taskerId,
    this.bookingId,
    this.bookingRef,
    this.customerId,
    this.createdBy,
    this.transactionRef,
    this.total,
    this.price,
    this.totalHoursWorked,
    this.basePrice,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
