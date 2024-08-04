// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceParams _$ServiceParamsFromJson(Map<String, dynamic> json) =>
    ServiceParams(
      merchantUid: json['merchantUid'] as String? ?? "M1000019",
      apiUserId: json['apiUserId'] as String? ?? "10000050",
      apiKey: json['apiKey'] as String? ?? "API-1588163548AHX",
      paymentMethod: json['paymentMethod'] as String? ?? "MWALLET_ACCOUNT",
      payerInfo: PayerInfo.fromJson(json['payerInfo'] as Map<String, dynamic>),
      transactionInfo: TransactionInfo.fromJson(
          json['transactionInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceParamsToJson(ServiceParams instance) =>
    <String, dynamic>{
      'merchantUid': instance.merchantUid,
      'apiUserId': instance.apiUserId,
      'apiKey': instance.apiKey,
      'paymentMethod': instance.paymentMethod,
      'payerInfo': instance.payerInfo.toJson(),
      'transactionInfo': instance.transactionInfo.toJson(),
    };
