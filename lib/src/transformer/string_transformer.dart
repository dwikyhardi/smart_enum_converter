import 'package:json_annotation/json_annotation.dart';
import 'package:recase/recase.dart';

/// Utility class for string transformations based on FieldRename policies
class StringTransformer {
  const StringTransformer._();

  /// Converts a string to kebab-case
  /// Example: "testValue" -> "test-value"
  static String toKebabCase(String input) {
    if (input.isEmpty) return input;
    return input.paramCase;
  }

  /// Converts a string to snake_case
  /// Example: "testValue" -> "test_value"
  static String toSnakeCase(String input) {
    if (input.isEmpty) return input;
    return input.snakeCase;
  }

  /// Converts a string to PascalCase
  /// Example: "testValue" -> "TestValue"
  static String toPascalCase(String input) {
    if (input.isEmpty) return input;
    return input.pascalCase;
  }

  /// Converts a string to SCREAMING_SNAKE_CASE
  /// Example: "testValue" -> "TEST_VALUE"
  static String toScreamingSnakeCase(String input) =>
      toSnakeCase(input).toUpperCase();

  /// Applies the specified FieldRename policy to the input string
  static String applyFieldRename(String input, FieldRename? policy) =>
      switch (policy) {
        FieldRename.kebab => toKebabCase(input),
        FieldRename.snake => toSnakeCase(input),
        FieldRename.pascal => toPascalCase(input),
        FieldRename.screamingSnake => toScreamingSnakeCase(input),
        FieldRename.none || null => input
      };
}
