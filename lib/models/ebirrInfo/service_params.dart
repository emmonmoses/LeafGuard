// Package imports:
// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/ebirrInfo/payer_info.dart';
import 'package:leafguard/models/ebirrInfo/transaction_info.dart';

part 'service_params.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceParams {
  String merchantUid;
  String apiUserId;
  String apiKey;
  String paymentMethod;
  PayerInfo payerInfo;
  TransactionInfo transactionInfo;

  ServiceParams({
    // required this.merchantUid,
    // required this.apiUserId,
    // required this.apiKey,
    // required this.paymentMethod,
    this.merchantUid = "M1000019",
    this.apiUserId = "10000050",
    this.apiKey = "API-1588163548AHX",
    this.paymentMethod = "MWALLET_ACCOUNT",
    required this.payerInfo,
    required this.transactionInfo,
  });

  factory ServiceParams.fromJson(Map<String, dynamic> json) =>
      _$ServiceParamsFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceParamsToJson(this);
}
