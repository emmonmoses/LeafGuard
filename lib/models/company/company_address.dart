import 'package:json_annotation/json_annotation.dart';
part 'company_address.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyAddress {
  String? city;
  String? country;

  CompanyAddress({this.city, this.country});

  factory CompanyAddress.fromJson(Map<String, dynamic> json) =>
      _$CompanyAddressFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyAddressToJson(this);
}
