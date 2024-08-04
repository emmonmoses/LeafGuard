import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/company/company_address.dart';
import 'package:leafguard/models/company/company_price.dart';
import 'package:leafguard/models/phone/phone.dart';
part 'company_update.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UpdateCompany {
  String? id;
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

  UpdateCompany({
    this.address,
    this.avatar,
    this.categoryId,
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

  factory UpdateCompany.fromJson(Map<String, dynamic> json) =>
      _$UpdateCompanyFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateCompanyToJson(this);
}
