// Project imports:

// ignore_for_file: non_constant_identifier_names

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'review_create.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewCreate {
  String? usertype;
  String? taskid;
  String? userid;
  String? taskerid;
  int? rating;
  String? comments;
  String? review;
  int? status;

  ReviewCreate({
    this.usertype,
    this.taskid,
    this.userid,
    this.taskerid,
    this.rating,
    this.comments,
    this.review,
    this.status,
  });
  factory ReviewCreate.fromJson(Map<String, dynamic> json) =>
      _$ReviewCreateFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewCreateToJson(this);
}
