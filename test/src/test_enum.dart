import 'package:smart_enum_converter/smart_enum_converter.dart';
import 'package:json_annotation/json_annotation.dart';

@SmartEnumConverter()
enum TestEnum {
  @JsonValue('first_value')
  first,
  
  @JsonValue('second_value')
  second,
  
  third
}

/// A [JsonConverter] that converts between [List<String>] and [List<PaymentTypeWrapper>].
///
/// Use this as an annotation on fields in your serializable classes:
/// ```dart
/// @ListPaymentTypeWrapperConverter()
/// final ListPaymentTypeWrapperConverter myEnums;
/// ```
// class ListPaymentTypeWrapperConverter
//     implements JsonConverter<List<PaymentTypeWrapper>, List<String>> {
//   /// Creates a const instance of [ListPaymentTypeWrapperConverter].
//   const ListPaymentTypeWrapperConverter();
//
//   /// Converts a JSON string to a [PaymentTypeWrapper].
//   ///
//   /// If the string matches a known enum value, returns a wrapper with that value.
//   /// Otherwise, returns a wrapper with an unknown value containing the original string.
//   @override
//   List<PaymentTypeWrapper> fromJson(List<String> jsonValues) => jsonValues
//       .map((jsonValue) =>
//       const PaymentTypeWrapperConverter().fromJson(jsonValue))
//       .toList();
//
//   /// Converts a [PaymentTypeWrapper] to a JSON string.
//   ///
//   /// Returns the original string value, whether it was a known enum value or an unknown value.
//   @override
//   List<String> toJson(List<PaymentTypeWrapper> object) =>
//       object.map((wrapper) => wrapper.toJsonValue()).toList();
// }