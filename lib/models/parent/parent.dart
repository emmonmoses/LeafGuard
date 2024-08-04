// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'parent.g.dart';

@JsonSerializable(explicitToJson: true)
class ParentCategory {
  String? id;
  String? name;
  String? type;

  ParentCategory({
    this.id,
    this.name,
    this.type,
  });

  factory ParentCategory.fromJson(Map<String, dynamic> json) =>
      _$ParentCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ParentCategoryToJson(this);
}
