// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancellation_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancellationRuleUpdate _$CancellationRuleUpdateFromJson(
        Map<String, dynamic> json) =>
    CancellationRuleUpdate(
      id: json['id'] as String,
      cancellation_reason: json['cancellation_reason'] as String,
      cancellation_user_type: json['cancellation_user_type'] as String?,
      cancellation_status: json['cancellation_status'] as int?,
    );

Map<String, dynamic> _$CancellationRuleUpdateToJson(
        CancellationRuleUpdate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cancellation_reason': instance.cancellation_reason,
      'cancellation_user_type': instance.cancellation_user_type,
      'cancellation_status': instance.cancellation_status,
    };
