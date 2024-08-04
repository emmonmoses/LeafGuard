// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'signin.g.dart';

@JsonSerializable(explicitToJson: true)
class SignIn {
  String? email;
  String? password;

  SignIn({
    this.email,
    this.password,
  });

  factory SignIn.fromJson(Map<String, dynamic> json) => _$SignInFromJson(json);
  Map<String, dynamic> toJson() => _$SignInToJson(this);
}
