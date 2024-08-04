// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'banking.g.dart';

@JsonSerializable(explicitToJson: true)
class Banking {
  String? acc_holder_name;
  String? acc_holder_address;
  String? acc_number;
  String? bank_name;
  String? branch_name;
  String? branch_address;
  String? swift_code;
  String? routing_number;

  Banking({
    this.acc_holder_name,
    this.acc_holder_address,
    this.acc_number,
    this.bank_name,
    this.branch_name,
    this.branch_address,
    this.swift_code,
    this.routing_number,
  });
  factory Banking.fromJson(Map<String, dynamic> json) =>
      _$BankingFromJson(json);
  Map<String, dynamic> toJson() => _$BankingToJson(this);
}
