import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/company/company.dart';
import 'package:leafguard/models/company/company_invoice.dart';
import 'package:leafguard/models/customer/customer.dart';
part 'company_booking.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyBooking {
  String? reference;
  String? customerId;
  String? customerNumber;
  String? service;
  String? paymentMode;
  int? numberOfProviders;
  int? workDuration;
  String? startDate;
  String? description;
  int? status;
  String? createdOn;
  String? id;
  CompanyInvoice? invoice;
  Company? company;
  Customer? customer;

  CompanyBooking({
    this.company,
    this.createdOn,
    this.customer,
    this.customerId,
    this.customerNumber,
    this.description,
    this.id,
    this.invoice,
    this.numberOfProviders,
    this.paymentMode,
    this.reference,
    this.service,
    this.startDate,
    this.status,
    this.workDuration,
  });

  factory CompanyBooking.fromJson(Map<String, dynamic> json) =>
      _$CompanyBookingFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyBookingToJson(this);
}
