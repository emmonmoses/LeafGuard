import 'package:json_annotation/json_annotation.dart';
part 'company_invoice.g.dart';
@JsonSerializable(explicitToJson: true)
class CompanyInvoice {
  String? paymentMode;
  int? numberOfProviders;
  int? workDuration;
  double? amount;
  double? totalAmount;
  bool? paid;

  CompanyInvoice(
      {this.amount,
      this.numberOfProviders,
      this.paid,
      this.paymentMode,
      this.totalAmount,
      this.workDuration});
  factory CompanyInvoice.fromJson(Map<String, dynamic> json) =>
      _$CompanyInvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyInvoiceToJson(this);
}
