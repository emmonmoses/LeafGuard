// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'category_main_create.g.dart';

@JsonSerializable(explicitToJson: true)
class MainCategoryCreate {
  String? name;
  String? image;
  String? description;

  MainCategoryCreate({
    this.name,
    this.image,
    this.description,
  });

  factory MainCategoryCreate.fromJson(Map<String, dynamic> json) =>
      _$MainCategoryCreateFromJson(json);
  Map<String, dynamic> toJson() => _$MainCategoryCreateToJson(this);
}
