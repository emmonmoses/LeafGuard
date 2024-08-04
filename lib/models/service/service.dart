// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/discount/discount.dart';
import 'package:leafguard/models/provider/provider.dart';
import 'package:leafguard/models/tax/tax.dart';

part 'service.g.dart';

@JsonSerializable(explicitToJson: true)
class Service {
  String? id;
  Tax? tax;
  Discount? discount;
  String? taskerId;
  String? categoryId;
  String? name;
  String? description;
  String? price;
  String? adminCommission;
  String? agentCommission;
  String? createdBy;
  DateTime? createdAt;
  Category? category;
  ServiceProvider? tasker;

  Service({
    this.id,
    this.tax,
    this.discount,
    this.taskerId,
    this.categoryId,
    this.name,
    this.description,
    this.price,
    this.adminCommission,
    this.agentCommission,
    this.createdBy,
    this.createdAt,
    this.category,
    this.tasker,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
