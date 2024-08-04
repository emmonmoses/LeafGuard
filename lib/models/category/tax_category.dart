import 'package:json_annotation/json_annotation.dart';

part 'tax_category.g.dart';

@JsonSerializable(explicitToJson: true)
class TaxCategoryUpdate {
  String? name;
  String? rate;
  bool? type;

  TaxCategoryUpdate({
    this.name,
    this.rate,
    this.type,
  });
  factory TaxCategoryUpdate.fromJson(Map<String, dynamic> json) =>
      _$TaxCategoryUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$TaxCategoryUpdateToJson(this);
}
