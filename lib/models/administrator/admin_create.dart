// Package imports:
import 'package:json_annotation/json_annotation.dart';


part 'admin_create.g.dart';

@JsonSerializable(explicitToJson: true)
class AdministratorCreate {
  int? status;
  String? name;
  String? email;
  String? username;
  String? password;

  AdministratorCreate({
    this.status,
    this.name,
    this.email,
    this.username,
    this.password,
  });

  factory AdministratorCreate.fromJson(Map<String, dynamic> json) =>
      _$AdministratorCreateFromJson(json);
  Map<String, dynamic> toJson() => _$AdministratorCreateToJson(this);
}
