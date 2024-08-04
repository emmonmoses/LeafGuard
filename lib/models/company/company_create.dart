import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/company/company_address.dart';
import 'package:leafguard/models/company/company_price.dart';
import 'package:leafguard/models/phone/phone.dart';
part 'company_create.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CompanyCreate {
  String? name;
  String? categoryId;
  String? currency;
  String? tinnumber;
  String? description;
  String? avatar;
  String? email;
  Phone? phone;
  CompanyAddress? address;
  CompanyPrice? pricing;
  bool? status;

  CompanyCreate({
    this.name,
    this.address,
    this.avatar,
    this.categoryId,
    this.currency,
    this.description,
    this.email,
    this.phone,
    this.status,
    this.tinnumber,
    this.pricing,
  });

  factory CompanyCreate.fromJson(Map<String, dynamic> json) =>
      _$CompanyCreateFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyCreateToJson(this);
}
