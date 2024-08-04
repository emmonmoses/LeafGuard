// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  // String? line;
  String? line1;
  String? line2;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  // String? formatted_address;

  Address({
    // this.line,
    this.line1,
    this.line2,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    // this.formatted_address,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
