// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      delete: json['delete'] as bool,
      edit: json['edit'] as bool,
      add: json['add'] as bool,
      view: json['view'] as bool,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'delete': instance.delete,
      'edit': instance.edit,
      'add': instance.add,
      'view': instance.view,
    };
