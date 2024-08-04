// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

@JsonSerializable(explicitToJson: true)
class Invoice {
  String? hoursTakenToStartJob;
  String? basePrice;
  String? hoursWorkedBeforePause;
  String? hoursWorkedAfterPause;
  String? hoursWorkedFromStartFinish;
  String? originalServicePrice;
  String? newServicePrice;
  String? totalHoursWorked;
  String? taxTotal;
  String? discountTotal;
  String? priceWithTax;
  String? totalAdminCommission;
  String? totalAgentCommission;
  String? totalTaskerCommission;
  String? totalCommission;
  String? totalPrice;

  Invoice({
    this.hoursTakenToStartJob,
    this.basePrice,
    this.hoursWorkedBeforePause,
    this.hoursWorkedAfterPause,
    this.hoursWorkedFromStartFinish,
    this.originalServicePrice,
    this.newServicePrice,
    this.totalHoursWorked,
    this.taxTotal,
    this.discountTotal,
    this.priceWithTax,
    this.totalAdminCommission,
    this.totalAgentCommission,
    this.totalTaskerCommission,
    this.totalCommission,
    this.totalPrice,
  });
  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}
