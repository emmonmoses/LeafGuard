// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'cancellation_create.g.dart';

@JsonSerializable(explicitToJson: true)
class CancellationRuleCreate {
  String? cancellation_reason;
  String? cancellation_user_type;
  int? cancellation_status;

  CancellationRuleCreate({
    this.cancellation_reason,
    this.cancellation_user_type,
    this.cancellation_status,
  });

  factory CancellationRuleCreate.fromJson(Map<String, dynamic> json) =>
      _$CancellationRuleCreateFromJson(json);
  Map<String, dynamic> toJson() => _$CancellationRuleCreateToJson(this);
}
