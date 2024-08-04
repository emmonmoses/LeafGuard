// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['id'] as String?,
      cancelAction: json['cancelAction'] == null
          ? null
          : CancelAction.fromJson(json['cancelAction'] as Map<String, dynamic>),
      invoice: json['invoice'] == null
          ? null
          : Invoice.fromJson(json['invoice'] as Map<String, dynamic>),
      bookingRef: json['bookingRef'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      tasker: json['tasker'] as String?,
      service: (json['service'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      customerPrefferredJobStartDate: json['customerPrefferredJobStartDate'] ==
              null
          ? null
          : DateTime.parse(json['customerPrefferredJobStartDate'] as String),
      jobStatus: json['jobStatus'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      agentJobAcceptDate: json['agentJobAcceptDate'] == null
          ? null
          : DateTime.parse(json['agentJobAcceptDate'] as String),
      createdBy: json['createdBy'] as String?,
      agentJobStartDate: json['agentJobStartDate'] == null
          ? null
          : DateTime.parse(json['agentJobStartDate'] as String),
      hoursTakenToStartJob: json['hoursTakenToStartJob'] as String?,
      agentJobPauseDate: json['agentJobPauseDate'] == null
          ? null
          : DateTime.parse(json['agentJobPauseDate'] as String),
      hoursWorkedBeforePause: json['hoursWorkedBeforePause'] as String?,
      agentJobContinueDate: json['agentJobContinueDate'] == null
          ? null
          : DateTime.parse(json['agentJobContinueDate'] as String),
      agentJobCompleteDate: json['agentJobCompleteDate'] == null
          ? null
          : DateTime.parse(json['agentJobCompleteDate'] as String),
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'cancelAction': instance.cancelAction?.toJson(),
      'invoice': instance.invoice?.toJson(),
      'bookingRef': instance.bookingRef,
      'category': instance.category?.toJson(),
      'customer': instance.customer?.toJson(),
      'tasker': instance.tasker,
      'service': instance.service?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'customerPrefferredJobStartDate':
          instance.customerPrefferredJobStartDate?.toIso8601String(),
      'jobStatus': instance.jobStatus,
      'createdAt': instance.createdAt?.toIso8601String(),
      'agentJobAcceptDate': instance.agentJobAcceptDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'agentJobStartDate': instance.agentJobStartDate?.toIso8601String(),
      'hoursTakenToStartJob': instance.hoursTakenToStartJob,
      'agentJobPauseDate': instance.agentJobPauseDate?.toIso8601String(),
      'hoursWorkedBeforePause': instance.hoursWorkedBeforePause,
      'agentJobContinueDate': instance.agentJobContinueDate?.toIso8601String(),
      'agentJobCompleteDate': instance.agentJobCompleteDate?.toIso8601String(),
    };
