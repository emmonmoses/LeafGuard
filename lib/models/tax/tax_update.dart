// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'tax_update.g.dart';

@JsonSerializable(explicitToJson: true)
class TaxUpdate {
  String id;
  String? name;
  int? rate;
  String? description;
  int? status;

  TaxUpdate({
    required this.id,
    this.name,
    this.rate,
    this.description,
    this.status,
  });

  factory TaxUpdate.fromJson(Map<String, dynamic> json) =>
      _$TaxUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$TaxUpdateToJson(this);
}
