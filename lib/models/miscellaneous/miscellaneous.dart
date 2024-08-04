// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'miscellaneous.g.dart';

@JsonSerializable(explicitToJson: true)
class Miscellaneous {
  int? price;
  String? name;

  Miscellaneous({
    this.price,
    this.name,
  });

  factory Miscellaneous.fromJson(Map<String, dynamic> json) =>
      _$MiscellaneousFromJson(json);
  Map<String, dynamic> toJson() => _$MiscellaneousToJson(this);
}
