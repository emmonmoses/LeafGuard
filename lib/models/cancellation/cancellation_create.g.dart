// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancellation_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancellationRuleCreate _$CancellationRuleCreateFromJson(
        Map<String, dynamic> json) =>
    CancellationRuleCreate(
      cancellation_reason: json['cancellation_reason'] as String?,
      cancellation_user_type: json['cancellation_user_type'] as String?,
      cancellation_status: json['cancellation_status'] as int?,
    );

Map<String, dynamic> _$CancellationRuleCreateToJson(
        CancellationRuleCreate instance) =>
    <String, dynamic>{
      'cancellation_reason': instance.cancellation_reason,
      'cancellation_user_type': instance.cancellation_user_type,
      'cancellation_status': instance.cancellation_status,
    };
