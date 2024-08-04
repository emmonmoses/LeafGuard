// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Amount _$AmountFromJson(Map<String, dynamic> json) => Amount(
      task_cost: json['task_cost'] as int?,
      service_tax: json['service_tax'] as int?,
      service_discount: json['service_discount'] as int?,
      admin_commission: (json['admin_commission'] as num?)?.toDouble(),
      total: json['total'] as int?,
      grand_total: json['grand_total'] as int?,
      minimum_cost: json['minimum_cost'] as int?,
      extra_amount: json['extra_amount'] as int?,
      balance_amount: json['balance_amount'] as int?,
      worked_hours_cost: json['worked_hours_cost'] as int?,
    );

Map<String, dynamic> _$AmountToJson(Amount instance) => <String, dynamic>{
      'task_cost': instance.task_cost,
      'service_tax': instance.service_tax,
      'service_discount': instance.service_discount,
      'admin_commission': instance.admin_commission,
      'total': instance.total,
      'grand_total': instance.grand_total,
      'minimum_cost': instance.minimum_cost,
      'extra_amount': instance.extra_amount,
      'balance_amount': instance.balance_amount,
      'worked_hours_cost': instance.worked_hours_cost,
    };
