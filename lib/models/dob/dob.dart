// Package imports:

import 'package:json_annotation/json_annotation.dart';
part 'dob.g.dart';

@JsonSerializable()
class BirthDate {
  int? year;
  int? month;
  int? date;

  BirthDate({
    this.year,
    this.month,
    this.date,
  });

  factory BirthDate.fromJson(Map<String, dynamic> json) =>
      _$BirthDateFromJson(json);
  Map<String, dynamic> toJson() => _$BirthDateToJson(this);
}
