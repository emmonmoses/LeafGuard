// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'service_update.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceUpdate {
  String id;
  String? taskerId;
  List<String>? categoryId;
  String? description;
  String? createdBy;
  ////////////////
  // String? categoryId;
  // String? name;
  // String? price;
  // String? price_rate;
  // Tax? tax;
  // Discount? discount;
  // String? commissionRate;
  // int? status;

  ServiceUpdate({
    required this.id,
    this.taskerId,
    this.categoryId,
    this.description,
    this.createdBy,
    //////////
    // this.name,
    // this.price,
    // this.price_rate,
    // this.tax,
    // this.discount,
    // this.commissionRate,
    // this.status,
  });

  factory ServiceUpdate.fromJson(Map<String, dynamic> json) =>
      _$ServiceUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceUpdateToJson(this);
}
