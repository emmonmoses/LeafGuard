// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewCreate _$ReviewCreateFromJson(Map<String, dynamic> json) => ReviewCreate(
      usertype: json['usertype'] as String?,
      taskid: json['taskid'] as String?,
      userid: json['userid'] as String?,
      taskerid: json['taskerid'] as String?,
      rating: json['rating'] as int?,
      comments: json['comments'] as String?,
      review: json['review'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$ReviewCreateToJson(ReviewCreate instance) =>
    <String, dynamic>{
      'usertype': instance.usertype,
      'taskid': instance.taskid,
      'userid': instance.userid,
      'taskerid': instance.taskerid,
      'rating': instance.rating,
      'comments': instance.comments,
      'review': instance.review,
      'status': instance.status,
    };
