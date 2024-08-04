// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'verification_code.g.dart';

@JsonSerializable(explicitToJson: true)
class VerificationCode {
  String? id;
  int? email;

  VerificationCode({
    this.id,
    this.email,
  });
  factory VerificationCode.fromJson(Map<String, dynamic> json) =>
      _$VerificationCodeFromJson(json);
  Map<String, dynamic> toJson() => _$VerificationCodeToJson(this);
}
