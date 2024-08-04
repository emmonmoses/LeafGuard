// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/address/address.dart';
import 'package:leafguard/models/phone/phone.dart';

part 'customer_create.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerCreate {
  int? status;
  String? name;
  String? email;
  String? username;
  String? password;
  Address? address;
  Phone? phone;
  String? avatar;
  String? document;
  String? dateOfBirth;
  String? documentType;

  CustomerCreate(
      {this.status,
      this.name,
      this.email,
      this.username,
      this.password,
      this.address,
      this.phone,
      this.avatar,
      this.document,
      this.documentType,
      this.dateOfBirth});

  factory CustomerCreate.fromJson(Map<String, dynamic> json) =>
      _$CustomerCreateFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerCreateToJson(this);
}
