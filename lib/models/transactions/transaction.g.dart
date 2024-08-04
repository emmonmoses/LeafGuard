// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      tax: json['tax'] == null
          ? null
          : Tax.fromJson(json['tax'] as Map<String, dynamic>),
      discount: json['discount'] == null
          ? null
          : Discount.fromJson(json['discount'] as Map<String, dynamic>),
      adminCommission: json['adminCommission'] == null
          ? null
          : Commission.fromJson(
              json['adminCommission'] as Map<String, dynamic>),
      agentCommission: json['agentCommission'] == null
          ? null
          : Commission.fromJson(
              json['agentCommission'] as Map<String, dynamic>),
      taskerCommission: json['taskerCommission'] == null
          ? null
          : Commission.fromJson(
              json['taskerCommission'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      tasker: json['tasker'] == null
          ? null
          : ServiceProvider.fromJson(json['tasker'] as Map<String, dynamic>),
      transactionDate: json['transactionDate'] == null
          ? null
          : DateTime.parse(json['transactionDate'] as String),
      id: json['id'] as String?,
      taskerId: json['taskerId'] as String?,
      bookingId: json['bookingId'] as String?,
      bookingRef: json['bookingRef'] as String?,
      customerId: json['customerId'] as String?,
      createdBy: json['createdBy'] as String?,
      transactionRef: json['transactionRef'] as String?,
      total: json['total'] as String?,
      price: json['price'] as String?,
      totalHoursWorked: json['totalHoursWorked'] as String?,
      basePrice: json['basePrice'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'tax': instance.tax?.toJson(),
      'discount': instance.discount?.toJson(),
      'adminCommission': instance.adminCommission?.toJson(),
      'agentCommission': instance.agentCommission?.toJson(),
      'taskerCommission': instance.taskerCommission?.toJson(),
      'category': instance.category?.toJson(),
      'service': instance.service?.toJson(),
      'customer': instance.customer?.toJson(),
      'tasker': instance.tasker?.toJson(),
      'transactionDate': instance.transactionDate?.toIso8601String(),
      'id': instance.id,
      'taskerId': instance.taskerId,
      'bookingId': instance.bookingId,
      'bookingRef': instance.bookingRef,
      'customerId': instance.customerId,
      'createdBy': instance.createdBy,
      'transactionRef': instance.transactionRef,
      'total': instance.total,
      'price': instance.price,
      'totalHoursWorked': instance.totalHoursWorked,
      'basePrice': instance.basePrice,
    };
