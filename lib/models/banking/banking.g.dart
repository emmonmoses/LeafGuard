// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banking _$BankingFromJson(Map<String, dynamic> json) => Banking(
      acc_holder_name: json['acc_holder_name'] as String?,
      acc_holder_address: json['acc_holder_address'] as String?,
      acc_number: json['acc_number'] as String?,
      bank_name: json['bank_name'] as String?,
      branch_name: json['branch_name'] as String?,
      branch_address: json['branch_address'] as String?,
      swift_code: json['swift_code'] as String?,
      routing_number: json['routing_number'] as String?,
    );

Map<String, dynamic> _$BankingToJson(Banking instance) => <String, dynamic>{
      'acc_holder_name': instance.acc_holder_name,
      'acc_holder_address': instance.acc_holder_address,
      'acc_number': instance.acc_number,
      'bank_name': instance.bank_name,
      'branch_name': instance.branch_name,
      'branch_address': instance.branch_address,
      'swift_code': instance.swift_code,
      'routing_number': instance.routing_number,
    };
