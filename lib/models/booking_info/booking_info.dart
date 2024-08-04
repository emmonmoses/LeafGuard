// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/category/category.dart';
import 'package:leafguard/models/service/service.dart';

part 'booking_info.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingInformation {
  String? work_type; // category
  String? service_type; // service
  String? instruction;
  String? est_reach_date;
  // I need these
  Category? category;
  List<Service>? services;
  String? booking_date;

  BookingInformation({
    this.work_type,
    this.service_type,
    this.instruction,
    this.est_reach_date,
    // I need these
    this.category,
    this.services,
    this.booking_date,
  });
  factory BookingInformation.fromJson(Map<String, dynamic> json) =>
      _$BookingInformationFromJson(json);
  Map<String, dynamic> toJson() => _$BookingInformationToJson(this);
}
