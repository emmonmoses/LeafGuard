// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews(
      id: json['id'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      type: json['type'] as String?,
      task: json['task'] as String?,
      user: json['user'] as String?,
      tasker: json['tasker'] as String?,
      comments: json['comments'] as String?,
      image: json['image'] as String?,
      rating: json['rating'] as int?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'type': instance.type,
      'task': instance.task,
      'user': instance.user,
      'tasker': instance.tasker,
      'comments': instance.comments,
      'image': instance.image,
      'rating': instance.rating,
      'status': instance.status,
    };
