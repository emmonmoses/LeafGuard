// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lng: (json['lng'] as num?)?.toDouble() ?? 38.763611,
      log: (json['log'] as num?)?.toDouble() ?? 38.763611,
      lat: (json['lat'] as num?)?.toDouble() ?? 9.005401,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lng': instance.lng,
      'log': instance.log,
      'lat': instance.lat,
    };
