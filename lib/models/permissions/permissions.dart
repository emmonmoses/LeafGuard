// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/actions/actions.dart';

// Project imports:

part 'permissions.g.dart';

@JsonSerializable(explicitToJson: true)
class Permissions {
  // String? id;
  String? module;
  List<ActionMenu>? actions;

  Permissions({
    // this.id,
    this.module,
    this.actions,
  });

  factory Permissions.fromJson(Map<String, dynamic> json) =>
      _$PermissionsFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionsToJson(this);
}
