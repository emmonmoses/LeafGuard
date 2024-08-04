// Package imports:
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';


part 'service_create.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceCreate {
  String? taskerId;
  List<String>? categoryId;
  String? description;
  String? createdBy;

  ServiceCreate({
    this.taskerId,
    this.categoryId,
    this.description,
    this.createdBy,
  });

  factory ServiceCreate.fromJson(Map<String, dynamic> json) =>
      _$ServiceCreateFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceCreateToJson(this);
}
