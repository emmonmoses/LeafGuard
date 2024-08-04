// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/category_main/category_main.dart';
import 'package:leafguard/models/discount/discount.dart';
import 'package:leafguard/models/tax/tax.dart';

part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  String? id;
  Tax? tax;
  Discount? discount;
  String? maincategoryId;
  String? name;
  String? description;
  String? avatar;
  String? price;
  String? adminCommission;
  String? agentCommission;
  int? status;
  DateTime? createdAt;
  MainCategory? maincategory;

  Category({
    this.id,
    this.tax,
    this.discount,
    this.maincategoryId,
    this.name,
    this.description,
    this.avatar,
    this.price,
    this.adminCommission,
    this.agentCommission,
    this.status,
    this.createdAt,
    this.maincategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
