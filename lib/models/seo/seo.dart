// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'seo.g.dart';

@JsonSerializable(explicitToJson: true)
class Seo {
  String? keyword;
  String? title;
  String? description;

  Seo({
    this.keyword,
    this.title,
    this.description = '',
  });

  factory Seo.fromJson(Map<String, dynamic> json) => _$SeoFromJson(json);
  Map<String, dynamic> toJson() => _$SeoToJson(this);
}
