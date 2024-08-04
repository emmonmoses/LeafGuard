// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:leafguard/models/activity/activity.dart';
import 'package:leafguard/models/permissions/permissions.dart';

part 'admin.g.dart';

@JsonSerializable(explicitToJson: true)
class Administrator {
  int? status;
  String? id;
  String? adminNumber;
  DateTime? updatedAt;
  String? username;
  DateTime? createdAt;
  String? name;
  String? email;
  String? role;
  // String? password;
  Activity? activity;
  List<Permissions>? permissions;

  Administrator({
    this.status = 1,
    this.id,
    this.adminNumber,
    this.updatedAt,
    this.username,
    this.createdAt,
    this.name,
    this.email,
    this.role,
    // this.password,
    this.activity,
    this.permissions,
  });

  factory Administrator.fromJson(Map<String, dynamic> json) =>
      _$AdministratorFromJson(json);
  Map<String, dynamic> toJson() => _$AdministratorToJson(this);
}
