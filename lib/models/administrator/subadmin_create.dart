// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/permissions/permissions.dart';

part 'subadmin_create.g.dart';

@JsonSerializable(explicitToJson: true)
class SubAdministratorCreate {
  int? status;
  String? name;
  String? email;
  String? username;
  String? password;
  List<Permissions>? permissions;

  SubAdministratorCreate({
    this.status,
    this.name,
    this.email,
    this.username,
    this.password,
    this.permissions,
  });

  factory SubAdministratorCreate.fromJson(Map<String, dynamic> json) =>
      _$SubAdministratorCreateFromJson(json);
  Map<String, dynamic> toJson() => _$SubAdministratorCreateToJson(this);
}
