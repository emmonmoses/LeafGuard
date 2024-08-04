// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'address_witness.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressWitness {
  String? line;
  String? city;
  String? state;
  String? country;

  AddressWitness({
    this.line,
    this.city,
    this.state,
    this.country,
  });

  factory AddressWitness.fromJson(Map<String, dynamic> json) =>
      _$AddressWitnessFromJson(json);
  Map<String, dynamic> toJson() => _$AddressWitnessToJson(this);
}
