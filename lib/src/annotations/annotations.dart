/// Marks an enum for generation of a smart JSON converter.
///
/// Apply this annotation to a Dart enum to generate a corresponding
/// wrapper class (e.g., `MyEnumWrapper`) and a `JsonConverter`
/// (e.g., `MyEnumWrapperConverter`). This setup allows for robust
/// handling of enum values during JSON serialization/deserialization,
/// especially when encountering unknown string values from an API.
///
/// The generator respects `@JsonValue()` annotations on enum members and
/// `@JsonEnum(fieldRename: ...)` on the enum itself for determining
/// string representations.
///
/// Example:
/// ```dart
/// import 'package:json_annotation/json_annotation.dart';
/// import 'package:smart_enum_converter/smart_enum_converter.dart';
///
/// part 'my_enum.smart_enum_converter.g.dart';
///
/// @SmartEnumConverter()
/// @JsonEnum(fieldRename: FieldRename.kebabCase)
/// enum MyEnum {
///   firstValue,
///   @JsonValue('SECOND_VALUE_CUSTOM')
///   secondValue,
/// }
/// ```
///
/// The generated wrapper class provides:
/// - Access to the known enum value via `enumValue` property
/// - Access to the original string via `originalValue` property
/// - A way to check if the value is unknown via `isUnknown` property
/// - Constructors for creating wrappers with known or unknown values
///
/// The generated converter class implements `JsonConverter` and can be
/// used as an annotation on fields in your serializable classes.
class SmartEnumConverter {
  /// Creates a new instance of [SmartEnumConverter].
  ///
  /// This constructor is const to allow the annotation to be used in const contexts.
  const SmartEnumConverter();
}

