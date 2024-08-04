// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'tax.g.dart';

@JsonSerializable(explicitToJson: true)
class Tax {
  String? id;
  String? name;
  dynamic rate;
  dynamic type;
  dynamic amount_percentage;
  dynamic amount;
  String? description;
  int? status;
  String? createdAt;

  Tax({
    this.id,
    this.name,
    this.rate,
    this.type,
    this.amount_percentage,
    this.amount,
    this.description,
    this.status,
    this.createdAt,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);
  Map<String, dynamic> toJson() => _$TaxToJson(this);
}
