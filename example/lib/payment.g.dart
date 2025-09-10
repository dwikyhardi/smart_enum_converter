// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
      id: json['id'] as String?,
      pk: json['pk'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      baseAmount: (json['baseAmount'] as num?)?.toDouble(),
      fee: (json['fee'] as num?)?.toDouble(),
      cashback: (json['cashback'] as num?)?.toDouble(),
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      paymentType:
          const APaymentType().fromJson(json['paymentType'] as String?),
      paymentTypes: const AListPaymentType()
          .fromJson(json['paymentTypes'] as List<String?>?),
    );

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
      'id': instance.id,
      'pk': instance.pk,
      'paymentMethod': instance.paymentMethod,
      'paymentStatus': instance.paymentStatus,
      'amount': instance.amount,
      'baseAmount': instance.baseAmount,
      'fee': instance.fee,
      'cashback': instance.cashback,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'paymentType': const APaymentType().toJson(instance.paymentType),
      'paymentTypes': const AListPaymentType().toJson(instance.paymentTypes),
    };
