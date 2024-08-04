// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'upload.g.dart';

@JsonSerializable(explicitToJson: true)
class UploadCategory {
  String? image;

  UploadCategory({
    this.image,
  });

  factory UploadCategory.fromJson(Map<String, dynamic> json) => _$UploadCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$UploadCategoryToJson(this);
}
