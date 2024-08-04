// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'commission.g.dart';

@JsonSerializable(explicitToJson: true)
class Commission {
  String? rate;
  String? amount;

  Commission({
    this.rate,
    this.amount,
  });

  factory Commission.fromJson(Map<String, dynamic> json) =>
      _$CommissionFromJson(json);
  Map<String, dynamic> toJson() => _$CommissionToJson(this);
}