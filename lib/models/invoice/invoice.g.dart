// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      hoursTakenToStartJob: json['hoursTakenToStartJob'] as String?,
      basePrice: json['basePrice'] as String?,
      hoursWorkedBeforePause: json['hoursWorkedBeforePause'] as String?,
      hoursWorkedAfterPause: json['hoursWorkedAfterPause'] as String?,
      hoursWorkedFromStartFinish: json['hoursWorkedFromStartFinish'] as String?,
      originalServicePrice: json['originalServicePrice'] as String?,
      newServicePrice: json['newServicePrice'] as String?,
      totalHoursWorked: json['totalHoursWorked'] as String?,
      taxTotal: json['taxTotal'] as String?,
      discountTotal: json['discountTotal'] as String?,
      priceWithTax: json['priceWithTax'] as String?,
      totalAdminCommission: json['totalAdminCommission'] as String?,
      totalAgentCommission: json['totalAgentCommission'] as String?,
      totalTaskerCommission: json['totalTaskerCommission'] as String?,
      totalCommission: json['totalCommission'] as String?,
      totalPrice: json['totalPrice'] as String?,
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'hoursTakenToStartJob': instance.hoursTakenToStartJob,
      'basePrice': instance.basePrice,
      'hoursWorkedBeforePause': instance.hoursWorkedBeforePause,
      'hoursWorkedAfterPause': instance.hoursWorkedAfterPause,
      'hoursWorkedFromStartFinish': instance.hoursWorkedFromStartFinish,
      'originalServicePrice': instance.originalServicePrice,
      'newServicePrice': instance.newServicePrice,
      'totalHoursWorked': instance.totalHoursWorked,
      'taxTotal': instance.taxTotal,
      'discountTotal': instance.discountTotal,
      'priceWithTax': instance.priceWithTax,
      'totalAdminCommission': instance.totalAdminCommission,
      'totalAgentCommission': instance.totalAgentCommission,
      'totalTaskerCommission': instance.totalTaskerCommission,
      'totalCommission': instance.totalCommission,
      'totalPrice': instance.totalPrice,
    };
