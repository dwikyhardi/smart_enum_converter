import 'dart:convert';

import 'package:example/payment.dart';
import 'package:example/payment_type.dart';

void main() {
  // Example 1: Using the enum directly
  print('Example 1: Using the enum directly');
  const creditCard = PaymentType.creditCard;
  print('Credit card enum: $creditCard');

  // Example 2: Creating a wrapper for a known enum value
  print('\nExample 2: Creating a wrapper for a known enum value');
  final knownWrapper = WPaymentType.known(PaymentType.bankTransfer);
  print('Known wrapper: $knownWrapper');
  print('Is unknown? ${knownWrapper.isUnknown}');
  print('Enum value: ${knownWrapper.enumValue}');
  print('Original value: ${knownWrapper.originalValue}');

  // Example 3: Creating a wrapper for an unknown enum value
  print('\nExample 3: Creating a wrapper for an unknown enum value');
  final unknownWrapper = WPaymentType.unknown('CASH_ON_DELIVERY');
  print('Unknown wrapper: $unknownWrapper');
  print('Is unknown? ${unknownWrapper.isUnknown}');
  print('Enum value: ${unknownWrapper.enumValue}');
  print('Original value: ${unknownWrapper.originalValue}');

  // Example 4: Using the converter directly
  print('\nExample 4: Using the converter directly');
  final converter = APaymentType();

  // Convert from JSON string to wrapper
  final fromJsonWrapper = converter.fromJson('QR_PAYMENT');
  print('From JSON wrapper: $fromJsonWrapper');
  print('Is unknown? ${fromJsonWrapper?.isUnknown}');
  print('Enum value: ${fromJsonWrapper?.enumValue}');

  // Convert from wrapper to JSON string
  final toJsonString = converter.toJson(knownWrapper);
  print('To JSON string: $toJsonString');

  // Example 5: Handling unknown values
  print('\nExample 5: Handling unknown values');
  final unknownFromJson = converter.fromJson('BITCOIN');
  print('Unknown from JSON: $unknownFromJson');
  print('Is unknown? ${unknownFromJson?.isUnknown}');
  print('Original value preserved: ${unknownFromJson?.originalValue}');

  // Example 6: Using with a model class (Payment)
  print('\nExample 6: Using with a model class (Payment)');

  // Create a payment with a known payment type
  final payment1 = Payment(
    id: '12345',
    amount: 100.0,
    paymentTypes: [WPaymentType.known(PaymentType.eWallet)],
    description: 'E-wallet payment example',
  );

  // Convert to JSON
  final payment1Json = payment1.toJson();
  print('Payment with known type as JSON: ${jsonEncode(payment1Json)}');

  // Create a payment with an unknown payment type
  final payment2 = Payment(
    id: '67890',
    amount: 200.0,
    paymentTypes: [WPaymentType.unknown('CRYPTO')],
    description: 'Cryptocurrency payment example',
  );

  // Convert to JSON
  final payment2Json = payment2.toJson();
  print('Payment with unknown type as JSON: ${jsonEncode(payment2Json)}');

  // Example 7: Deserializing from JSON
  print('\nExample 7: Deserializing from JSON');

  // JSON with a known payment type
  final knownJson = {
    'id': 'abc123',
    'amount': 150.0,
    'paymentType': 'DEBIT_CARD',
    'paymentTypes': ['DEBIT_CARD', 'CREDIT_CARD'],
    'description': 'Debit card payment',
  };

  // Parse the JSON
  final paymentFromKnown = Payment.fromJson(knownJson);
  print('Payment from known JSON: $paymentFromKnown');
  print('Payment type: ${paymentFromKnown.paymentTypes?.first?.enumValue}');
  print('Is unknown? ${paymentFromKnown.paymentTypes?.first?.isUnknown}');

  // JSON with an unknown payment type
  final unknownJson = {
    'id': 'xyz789',
    'amount': 300.0,
    'paymentType': 'APPLE_PAY',
    'paymentTypes': ['APPLE_PAY', 'GOOGLE_PAY'],
    'description': 'Apple Pay payment',
  };

  // Parse the JSON
  final paymentFromUnknown = Payment.fromJson(unknownJson);
  print('Payment from unknown JSON: $paymentFromUnknown');
  print(
    'Payment type enum value: ${paymentFromUnknown.paymentTypes?.first?.enumValue}',
  );
  print('Is unknown? ${paymentFromUnknown.paymentTypes?.first?.isUnknown}');
  print(
    'Original value preserved: ${paymentFromUnknown.paymentTypes?.first?.originalValue}',
  );

  // Example 8: Empty wrapper
  print('\nExample 8: Empty wrapper');
  final emptyWrapper = WPaymentType();
  print('Empty wrapper: $emptyWrapper');
  print('Is unknown? ${emptyWrapper.isUnknown}');
  print('Original value: ${emptyWrapper.originalValue}');
}
