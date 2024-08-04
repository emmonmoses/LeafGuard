// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'category_main.g.dart';

@JsonSerializable(explicitToJson: true)
class MainCategory {
  String? id;
  String? name;
  String? image;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  MainCategory({
    this.id,
    this.name,
    this.image,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) =>
      _$MainCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$MainCategoryToJson(this);
}
