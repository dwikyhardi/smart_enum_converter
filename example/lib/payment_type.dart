import 'package:json_annotation/json_annotation.dart';
import 'package:smart_enum_converter/smart_enum_converter.dart';

part 'payment_type.smart.dart';

@SmartEnumConverter()
enum PaymentType {
  /// Credit card payment
  @JsonValue('CREDIT_CARD')
  creditCard,

  /// Debit card payment
  @JsonValue('DEBIT_CARD')
  debitCard,

  /// Bank transfer payment
  @JsonValue('BANK_TRANSFER')
  bankTransfer,

  /// QR code payment
  @JsonValue('QR_PAYMENT')
  qrPayment,

  /// E-wallet payment
  @JsonValue('E_WALLET')
  eWallet,

  /// Unknown payment type
  unknown
}
