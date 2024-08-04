// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyInvoice _$CompanyInvoiceFromJson(Map<String, dynamic> json) =>
    CompanyInvoice(
      amount: (json['amount'] as num?)?.toDouble(),
      numberOfProviders: json['numberOfProviders'] as int?,
      paid: json['paid'] as bool?,
      paymentMode: json['paymentMode'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      workDuration: json['workDuration'] as int?,
    );

Map<String, dynamic> _$CompanyInvoiceToJson(CompanyInvoice instance) =>
    <String, dynamic>{
      'paymentMode': instance.paymentMode,
      'numberOfProviders': instance.numberOfProviders,
      'workDuration': instance.workDuration,
      'amount': instance.amount,
      'totalAmount': instance.totalAmount,
      'paid': instance.paid,
    };
