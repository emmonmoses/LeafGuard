// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'userratings.g.dart';

@JsonSerializable(explicitToJson: true)
class UserRating {
  List<dynamic>? ratings;

  UserRating({
    this.ratings,
  });

  factory UserRating.fromJson(Map<String, dynamic> json) =>
      _$UserRatingFromJson(json);
  Map<String, dynamic> toJson() => _$UserRatingToJson(this);
}
