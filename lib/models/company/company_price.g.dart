// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyPrice _$CompanyPriceFromJson(Map<String, dynamic> json) => CompanyPrice(
      hourly: (json['hourly'] as num?)?.toDouble(),
      monthly: (json['monthly'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CompanyPriceToJson(CompanyPrice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('hourly', instance.hourly);
  writeNotNull('monthly', instance.monthly);
  return val;
}
