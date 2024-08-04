// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'reviews.g.dart';

@JsonSerializable(explicitToJson: true)
class Reviews {
  String? id;
  String? updatedAt;
  String? createdAt;
  String? type;
  String? task;
  String? user;
  String? tasker;
  String? comments;
  String? image;
  int? rating;
  int? status;

  Reviews({
    this.id,
    this.updatedAt,
    this.createdAt,
    this.type,
    this.task,
    this.user,
    this.tasker,
    this.comments,
    this.image,
    this.rating,
    this.status,
  });
  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}
