// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:leafguard/models/userratings/userratings.dart';

part 'ratings.g.dart';

@JsonSerializable(explicitToJson: true)
class Rating {
  UserRating? user;

  Rating({
    this.user,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}
