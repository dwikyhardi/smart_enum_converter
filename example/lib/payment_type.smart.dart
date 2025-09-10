// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_type.dart';

// **************************************************************************
// SmartEnumConverterGenerator
// **************************************************************************

@JsonSerializable(
  createToJson: false,
  createFactory: false,
)
class WPaymentType {
  /// Creates a default constructor.
  WPaymentType([
    PaymentType? value,
    String? stringValue,
  ])  : enumValue = value,
        originalValue = stringValue;

  /// Creates a wrapper with a known enum value.
  ///
  /// The [value] parameter is the enum value to wrap.
  WPaymentType.known(PaymentType? value)
      : enumValue = value,
        originalValue = _getStringForEnum(value);

  /// Creates a wrapper for an unknown enum value.
  ///
  /// The [value] parameter is the original string value that couldn't be mapped to a known enum value.
  WPaymentType.unknown(String? value)
      : enumValue = null,
        originalValue = value;

  /// The known enum value if the original string was successfully mapped.
  /// Null if the original string was an unknown value.
  final PaymentType? enumValue;

  /// The original string value from JSON, always available.
  final String? originalValue;

  /// Returns true if this wrapper contains an unknown value that couldn't be mapped to a known enum value.
  bool get isUnknown => enumValue == null;

  /// Returns the string representation of this enum value for JSON serialization.
  String toJsonValue() => originalValue ?? 'UNKNOWN';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WPaymentType &&
        other.enumValue == enumValue &&
        other.originalValue == originalValue;
  }

  @override
  int get hashCode => enumValue.hashCode ^ originalValue.hashCode;

  @override
  String toString() =>
      'WPaymentType(enumValue: $enumValue, originalValue: $originalValue)';

  static String? _getStringForEnum(PaymentType? value) {
    switch (value) {
      case PaymentType.creditCard:
        return "CREDIT_CARD";
      case PaymentType.debitCard:
        return "DEBIT_CARD";
      case PaymentType.bankTransfer:
        return "BANK_TRANSFER";
      case PaymentType.qrPayment:
        return "QR_PAYMENT";
      case PaymentType.eWallet:
        return "E_WALLET";
      case PaymentType.unknown:
      default:
        return "unknown";
    }
  }
}

/// A [JsonConverter] that converts between [String] and [WPaymentType].
///
/// Use this as an annotation on fields in your serializable classes:
/// ```dart
/// @APaymentType()
/// final WPaymentType myEnum;
/// ```
class APaymentType implements JsonConverter<WPaymentType?, String?> {
  /// Creates a const instance of [APaymentType].
  const APaymentType();

  /// Converts a JSON string to a [WPaymentType].
  ///
  /// If the string matches a known enum value, returns a wrapper with that value.
  /// Otherwise, returns a wrapper with an unknown value containing the original string.
  @override
  WPaymentType? fromJson(String? jsonValue) {
    if (jsonValue == "CREDIT_CARD") {
      return WPaymentType.known(PaymentType.creditCard);
    }
    if (jsonValue == "DEBIT_CARD") {
      return WPaymentType.known(PaymentType.debitCard);
    }
    if (jsonValue == "BANK_TRANSFER") {
      return WPaymentType.known(PaymentType.bankTransfer);
    }
    if (jsonValue == "QR_PAYMENT") {
      return WPaymentType.known(PaymentType.qrPayment);
    }
    if (jsonValue == "E_WALLET") {
      return WPaymentType.known(PaymentType.eWallet);
    }
    if (jsonValue == "unknown") {
      return WPaymentType.known(PaymentType.unknown);
    }
    return WPaymentType.unknown(jsonValue);
  }

  /// Converts a [WPaymentType] to a JSON string.
  ///
  /// Returns the original string value, whether it was a known enum value or an unknown value.
  @override
  String toJson(WPaymentType? object) => object?.toJsonValue() ?? 'UNKNOWN';
}

/// A [JsonConverter] that converts between [List<String>] and [List<WPaymentType>].
///
/// Use this as an annotation on fields in your serializable classes:
/// ```dart
/// @AListPaymentType()
/// final ListWPaymentType? myEnum;
/// ```
class AListPaymentType
    implements JsonConverter<List<WPaymentType?>?, List<String?>?> {
  /// Creates a const instance of [AListPaymentType].
  const AListPaymentType();

  /// Converts a JSON string list to a [List<WPaymentType?>?].
  ///
  /// If the string matches a known enum value, returns a wrapper with that value.
  /// Otherwise, returns a wrapper with an unknown value containing the original string.
  @override
  List<WPaymentType?>? fromJson(List<String?>? jsonValues) => jsonValues
      ?.map((jsonValue) => const APaymentType().fromJson(jsonValue))
      .toList();

  /// Converts a [List<WPaymentType?>?] to a JSON string.
  ///
  /// Returns the original string value, whether it was a known enum value or an unknown value.
  @override
  List<String?>? toJson(List<WPaymentType?>? objects) =>
      objects?.map((wrapper) => wrapper?.toJsonValue()).toList();
}
