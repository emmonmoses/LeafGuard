// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'cancellation_update.g.dart';

@JsonSerializable(explicitToJson: true)
class CancellationRuleUpdate {
  String id;
  String cancellation_reason;
  String? cancellation_user_type;
  int? cancellation_status;

  CancellationRuleUpdate({
    required this.id,
    required this.cancellation_reason,
    this.cancellation_user_type,
    this.cancellation_status,
  });

  factory CancellationRuleUpdate.fromJson(Map<String, dynamic> json) =>
      _$CancellationRuleUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$CancellationRuleUpdateToJson(this);
}
