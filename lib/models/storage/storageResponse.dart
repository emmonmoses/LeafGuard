// Package imports:
// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/catalogue/catalogue.dart';

part 'storageResponse.g.dart';

@JsonSerializable()
class StorageResponse {
  final String id;
  final String name;
  final String fileKey;
  final String fileExtension;
  final String mimeType;
  Catalogue catalogueUrl;
  final DateTime createdAt;

  StorageResponse(
    this.id,
    this.name,
    this.fileKey,
    this.fileExtension,
    this.mimeType,
    this.catalogueUrl,
    this.createdAt,
  );

  factory StorageResponse.fromJson(Map<String, dynamic> json) =>
      _$StorageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StorageResponseToJson(this);
}
