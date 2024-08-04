// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyBooking _$CompanyBookingFromJson(Map<String, dynamic> json) =>
    CompanyBooking(
      company: json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
      createdOn: json['createdOn'] as String?,
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      customerId: json['customerId'] as String?,
      customerNumber: json['customerNumber'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String?,
      invoice: json['invoice'] == null
          ? null
          : CompanyInvoice.fromJson(json['invoice'] as Map<String, dynamic>),
      numberOfProviders: json['numberOfProviders'] as int?,
      paymentMode: json['paymentMode'] as String?,
      reference: json['reference'] as String?,
      service: json['service'] as String?,
      startDate: json['startDate'] as String?,
      status: json['status'] as int?,
      workDuration: json['workDuration'] as int?,
    );

Map<String, dynamic> _$CompanyBookingToJson(CompanyBooking instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'customerId': instance.customerId,
      'customerNumber': instance.customerNumber,
      'service': instance.service,
      'paymentMode': instance.paymentMode,
      'numberOfProviders': instance.numberOfProviders,
      'workDuration': instance.workDuration,
      'startDate': instance.startDate,
      'description': instance.description,
      'status': instance.status,
      'createdOn': instance.createdOn,
      'id': instance.id,
      'invoice': instance.invoice?.toJson(),
      'company': instance.company?.toJson(),
      'customer': instance.customer?.toJson(),
    };
