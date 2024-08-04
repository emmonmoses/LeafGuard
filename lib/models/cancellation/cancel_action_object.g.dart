// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_action_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelActionObject _$CancelActionObjectFromJson(Map<String, dynamic> json) =>
    CancelActionObject(
      cancelAction: json['cancelAction'] == null
          ? null
          : CancelAction.fromJson(json['cancelAction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CancelActionObjectToJson(CancelActionObject instance) =>
    <String, dynamic>{
      'cancelAction': instance.cancelAction?.toJson(),
    };
