// ignore_for_file: non_constant_identifier_names

// Project imports:
import 'package:leafguard/models/cancellation/cancel_Action.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/invoice/invoice.dart';
import 'package:leafguard/models/service/service.dart';

// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/customer/customer.dart';
part 'booking.g.dart';

@JsonSerializable(explicitToJson: true)
class Booking {
  String? id;
  CancelAction? cancelAction;
  Invoice? invoice;
  String? bookingRef;
  Category? category;
  Customer? customer;
  String? tasker;
  List<Service>? service;
  String? description;
  DateTime? customerPrefferredJobStartDate;
  int? jobStatus;
  DateTime? createdAt;
  DateTime? agentJobAcceptDate;
  String? createdBy;
  DateTime? agentJobStartDate;
  String? hoursTakenToStartJob;
  DateTime? agentJobPauseDate;
  String? hoursWorkedBeforePause;
  DateTime? agentJobContinueDate;
  DateTime? agentJobCompleteDate;

  Booking({
    this.id,
    this.cancelAction,
    this.invoice,
    this.bookingRef,
    this.category,
    this.customer,
    this.tasker,
    this.service,
    this.description,
    this.customerPrefferredJobStartDate,
    this.jobStatus,
    this.createdAt,
    this.agentJobAcceptDate,
    this.createdBy,
    this.agentJobStartDate,
    this.hoursTakenToStartJob,
    this.agentJobPauseDate,
    this.hoursWorkedBeforePause,
    this.agentJobContinueDate,
    this.agentJobCompleteDate,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
