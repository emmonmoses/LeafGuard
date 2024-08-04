import 'package:json_annotation/json_annotation.dart';
part 'skillattachments.g.dart';
@JsonSerializable(explicitToJson: true)
class Skillattachments {
  String? name;

  Skillattachments({
    this.name,
  });

  factory Skillattachments.fromJson(Map<String, dynamic> json) =>
      _$SkillattachmentsFromJson(json);
  Map<String, dynamic> toJson() => _$SkillattachmentsToJson(this);
}
