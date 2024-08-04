// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'rates.g.dart';

@JsonSerializable(explicitToJson: true)
class RateType {
  String? type;
  int? amount;

  RateType({
    this.type,
    this.amount,
  });

  factory RateType.fromJson(Map<String, dynamic> json) =>
      _$RateTypeFromJson(json);
  Map<String, dynamic> toJson() => _$RateTypeToJson(this);
}
