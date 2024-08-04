// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'status.g.dart';

@JsonSerializable(explicitToJson: true)
class Status {
  bool delete;
  bool edit;
  bool add;
  bool view;

  Status({
    required this.delete,
    required this.edit,
    required this.add,
    required this.view,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
  Map<String, dynamic> toJson() => _$StatusToJson(this);
}
