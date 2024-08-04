// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'rate.g.dart';

@JsonSerializable(explicitToJson: true)
class Rate {
  String? value;

  Rate({
    this.value,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => _$RateFromJson(json);
  Map<String, dynamic> toJson() => _$RateToJson(this);
}
