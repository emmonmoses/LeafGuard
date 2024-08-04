// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/permissions/permissions.dart';

part 'signin_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SignInResponse {
  int? status;
  String? id;
  String? name;
  String? admin;
  String? username;
  String? email;
  String? password;
  List<Permissions>? permissions;
  String? role;
  String? token;
  String? created;

  SignInResponse({
    this.status,
    this.id,
    this.name,
    this.admin,
    this.username,
    this.email,
    this.password,
    this.permissions,
    this.role,
    this.token,
    this.created,
  });
  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}
