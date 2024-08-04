// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'cancellation.g.dart';

@JsonSerializable(explicitToJson: true)
class CancellationRules {
  String? id;
  String? type; 
  String? reason;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? date; 

  CancellationRules({
    this.id,
    this.type,
    this.reason,
    this.status = 1,
    this.createdAt,
    this.updatedAt,
    this.date,
  });

  factory CancellationRules.fromJson(Map<String, dynamic> json) =>
      _$CancellationRulesFromJson(json);
  Map<String, dynamic> toJson() => _$CancellationRulesToJson(this);
}
