// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_Action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelAction _$CancelActionFromJson(Map<String, dynamic> json) => CancelAction(
      person: json['person'] as String?,
      personType: json['personType'] as String?,
      cancelReason: json['cancelReason'] as String?,
    )..cancelDate = json['cancelDate'] == null
        ? null
        : DateTime.parse(json['cancelDate'] as String);

Map<String, dynamic> _$CancelActionToJson(CancelAction instance) =>
    <String, dynamic>{
      'person': instance.person,
      'personType': instance.personType,
      'cancelReason': instance.cancelReason,
      'cancelDate': instance.cancelDate?.toIso8601String(),
    };
