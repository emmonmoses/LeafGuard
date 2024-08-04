// Package imports:

import 'package:json_annotation/json_annotation.dart';
part 'catalogue.g.dart';

@JsonSerializable()
class Catalogue {
  final String mainUrl;
  final List<String> thumbnailUrls;

  Catalogue(this.mainUrl, this.thumbnailUrls);

  factory Catalogue.fromJson(Map<String, dynamic> json) =>
      _$CatalogueFromJson(json);
  Map<String, dynamic> toJson() => _$CatalogueToJson(this);
}
