// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/discount/discount_catagory.dart';
import 'package:leafguard/models/tax/tax_catagory.dart';

part 'category_create.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryCreate {
  String name;
  String maincategoryId;
  String? description;
  dynamic avatar;
  String? price;
  TaxCatagory? tax;
  // disc is from existing discount in the db
  DiscountCatagory? discount;
  String? adminCommission; // defaults to 15% if not passed
  // String? agentCommission;
  int? status;

  CategoryCreate({
    required this.name,
    required this.maincategoryId,
    this.description,
    this.adminCommission,
    this.discount,
    this.avatar,
    this.status = 0,
    // this.agentCommission,
    this.tax,
    this.price,
  });

  factory CategoryCreate.fromJson(Map<String, dynamic> json) =>
      _$CategoryCreateFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryCreateToJson(this);
}
