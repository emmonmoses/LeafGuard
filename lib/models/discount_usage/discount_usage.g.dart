// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountUsage _$DiscountUsageFromJson(Map<String, dynamic> json) =>
    DiscountUsage(
      total_coupons: json['total_coupons'] as int?,
      per_user: json['per_user'] as int?,
    );

Map<String, dynamic> _$DiscountUsageToJson(DiscountUsage instance) =>
    <String, dynamic>{
      'total_coupons': instance.total_coupons,
      'per_user': instance.per_user,
    };
