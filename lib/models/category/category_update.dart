// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/category/discount_category.dart';
import 'package:leafguard/models/category/tax_category.dart';

part 'category_update.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryUpdate {
  String? id;
  TaxCategoryUpdate? tax;
  DiscountCategoryUpdate? discount;
  String? maincategoryId;
  String? name;
  String? description;
  String? avatar;
  String? price;
  String? adminCommission;
  String? agentCommission;
  int? status;

  CategoryUpdate({
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
  });

  factory CategoryUpdate.fromJson(Map<String, dynamic> json) =>
      _$CategoryUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryUpdateToJson(this);
}
