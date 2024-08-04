import 'package:json_annotation/json_annotation.dart';

part 'discount_category.g.dart';

@JsonSerializable(explicitToJson: true)
class DiscountCategoryUpdate {
  String? name;
  String? rate;

  DiscountCategoryUpdate({
    this.name,
    this.rate,
  });

  factory DiscountCategoryUpdate.fromJson(Map<String, dynamic> json) =>
      _$DiscountCategoryUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountCategoryUpdateToJson(this);
}
