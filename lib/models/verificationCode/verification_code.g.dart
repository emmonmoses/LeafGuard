// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationCode _$VerificationCodeFromJson(Map<String, dynamic> json) =>
    VerificationCode(
      id: json['id'] as String?,
      email: json['email'] as int?,
    );

Map<String, dynamic> _$VerificationCodeToJson(VerificationCode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
    };
