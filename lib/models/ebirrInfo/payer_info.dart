// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'payer_info.g.dart';

@JsonSerializable(explicitToJson: true)
class PayerInfo {
  String accountNo;

  PayerInfo({
    // required this.accountNo,
    this.accountNo = "0902425299",
  });

  factory PayerInfo.fromJson(Map<String, dynamic> json) =>
      _$PayerInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PayerInfoToJson(this);
}
