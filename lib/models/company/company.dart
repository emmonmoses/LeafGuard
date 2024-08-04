import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/company/company_address.dart';
import 'package:leafguard/models/company/company_price.dart';
import 'package:leafguard/models/phone/phone.dart';
part 'company.g.dart';

@JsonSerializable(explicitToJson: true)
class Company {
  String? name;
  Category? category;
  String? currency;
  String? createdOn;
  String? code;
  String? tinnumber;
  String? description;
  String? avatar;
  String? id;
  String? email;
  Phone? phone;
  CompanyAddress? address;
  CompanyPrice? pricing;
  bool? status;

  Company({
    this.address,
    this.avatar,
    this.category,
    this.code,
    this.createdOn,
    this.currency,
    this.description,
    this.email,
    this.id,
    this.name,
    this.phone,
    this.pricing,
    this.status,
    this.tinnumber,
  });
  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
