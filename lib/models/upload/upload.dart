// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'upload.g.dart';

@JsonSerializable(explicitToJson: true)
class Upload {
  String? avatar;

  Upload({
    this.avatar,
  });

  factory Upload.fromJson(Map<String, dynamic> json) => _$UploadFromJson(json);
  Map<String, dynamic> toJson() => _$UploadToJson(this);
}
