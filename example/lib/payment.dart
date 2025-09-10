import 'package:example/payment_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.g.dart';

part 'payment.freezed.dart';

@freezed
abstract class Payment with _$Payment {
  const factory Payment({
    String? id,
    String? pk,
    String? paymentMethod,
    String? paymentStatus,
    double? amount,
    double? baseAmount,
    double? fee,
    double? cashback,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    @APaymentType() WPaymentType? paymentType,
    @AListPaymentType() List<WPaymentType?>? paymentTypes,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}
