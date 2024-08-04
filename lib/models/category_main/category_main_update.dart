// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'category_main_update.g.dart';

@JsonSerializable(explicitToJson: true)
class MainCategoryUpdate {
  String id;
  String? name;
  String? image;
  String? description;

  MainCategoryUpdate({
    required this.id,
    this.name,
    this.image,
    this.description,
  });

  factory MainCategoryUpdate.fromJson(Map<String, dynamic> json) =>
      _$MainCategoryUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$MainCategoryUpdateToJson(this);
}
