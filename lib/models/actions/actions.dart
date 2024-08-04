// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'actions.g.dart';

@JsonSerializable(explicitToJson: true)
class ActionMenu {
  // String? id;
  String? name;

  ActionMenu({
    // this.id,
    this.name,
  });

  factory ActionMenu.fromJson(Map<String, dynamic> json) =>
      _$ActionMenuFromJson(json);
  Map<String, dynamic> toJson() => _$ActionMenuToJson(this);
}
