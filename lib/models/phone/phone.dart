// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'phone.g.dart';

@JsonSerializable(explicitToJson: true)
class Phone {
  dynamic code;
  dynamic number;

  Phone({
    this.code,
    this.number,
  });
  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneToJson(this);
}
