import 'package:json_annotation/json_annotation.dart';
part 'company_price.g.dart';

@JsonSerializable(explicitToJson: true,includeIfNull: false)
class CompanyPrice {
  double? hourly;
  double? monthly;

  CompanyPrice({this.hourly, this.monthly});

  factory CompanyPrice.fromJson(Map<String, dynamic> json) =>
      _$CompanyPriceFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyPriceToJson(this);
}
