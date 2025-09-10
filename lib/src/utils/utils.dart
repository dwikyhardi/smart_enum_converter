import 'dart:math';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_enum_converter/src/transformer/string_transformer.dart';
import 'package:code_builder/code_builder.dart' as cb;
import 'package:source_gen/source_gen.dart';

class Utils {
  const Utils._();

  /// Gets the JSON string representation for an enum value
  ///
  /// This method respects the precedence:
  /// 1. @JsonValue annotation (if present)
  /// 2. @JsonEnum(fieldRename: ...) policy (if specified)
  /// 3. Default behavior (enum constant name as-is)
  static String getJsonStringForEnumValue(
    FieldElement enumValueElement,
    Map<String, String> explicitJsonValues,
    FieldRename? fieldRenamePolicy,
  ) {
    final enumConstantName = enumValueElement.name;

    // Check if there's an explicit @JsonValue annotation
    if (explicitJsonValues.containsKey(enumConstantName)) {
      return explicitJsonValues[enumConstantName]!;
    }

    // Apply the field rename policy to the enum constant name
    return StringTransformer.applyFieldRename(
      enumConstantName,
      fieldRenamePolicy,
    );
  }

  /// Extracts the value from a @JsonValue annotation on an enum constant
  static String? getJsonValueAnnotation(FieldElement enumValue) {
    // Look for @JsonValue annotation
    final jsonValueAnnotation =
        TypeChecker.fromRuntime(JsonValue).firstAnnotationOf(enumValue);

    if (jsonValueAnnotation != null) {
      // Extract the value from the annotation
      final valueField = jsonValueAnnotation.getField('value');
      final stringValue = valueField?.toStringValue();

      // Check if the value is a string literal
      if (valueField == null || stringValue == null) {
        throw InvalidGenerationSourceError(
          '`@JsonValue` on `${enumValue.name}` must have a String literal value.',
          element: enumValue,
          todo:
              'Ensure the argument to @JsonValue is a string literal (e.g., @JsonValue("MY_STRING")).',
        );
      }

      return stringValue;
    }

    return null;
  }

  /// Extracts the @JsonEnum annotation from an enum
  // Look for @JsonEnum annotation
  static DartObject? getJsonEnumAnnotation(EnumElement enumElement) =>
      TypeChecker.fromRuntime(JsonEnum).firstAnnotationOf(enumElement);

  /// Extracts the fieldRename policy from a @JsonEnum annotation
  static FieldRename? getFieldRenamePolicy(DartObject jsonEnumAnnotation) {
    // Get the fieldRename field from the annotation
    final fieldRenameObj = jsonEnumAnnotation.getField('fieldRename');

    if (fieldRenameObj == null || fieldRenameObj.isNull) {
      return null;
    }

    // Convert the enum index to FieldRename enum value
    final index = fieldRenameObj.getField('index')?.toIntValue();
    if (index != null) {
      switch (index) {
        case 0:
          return FieldRename.none;
        case 1:
          return FieldRename.kebab;
        case 2:
          return FieldRename.snake;
        case 3:
          return FieldRename.pascal;
        case 4:
          return FieldRename.screamingSnake;
        default:
          throw InvalidGenerationSourceError(
            'Unsupported FieldRename value with index: $index. Supported values are: none, kebab, snake, pascal, screamingSnake.',
            todo:
                'Use one of the supported FieldRename values: none, kebab, snake, pascal, screamingSnake.',
          );
      }
    }

    return null;
  }

  /// Generates the wrapper class for the enum
  static cb.Class generateWrapperClass({
    required String enumName,
    required List<FieldElement> enumValues,
    required Map<String, String> explicitJsonValues,
    FieldRename? fieldRenamePolicy,
  }) =>
      cb.Class((b) {
        b.annotations.add(
          cb.refer(
            'JsonSerializable(createToJson: false,createFactory: false,)',
          ),
        );
        b.name = 'W$enumName';

        // Add fields
        b.fields.add(
          cb.Field((f) {
            f
              ..name = 'enumValue'
              ..type = cb.refer('$enumName?')
              ..modifier = cb.FieldModifier.final$
              ..docs.add(
                '/// The known enum value if the original string was successfully mapped.',
              )
              ..docs
                  .add('/// Null if the original string was an unknown value.');
          }),
        );

        b.fields.add(
          cb.Field((f) {
            f
              ..name = 'originalValue'
              ..type = cb.refer('String?')
              ..modifier = cb.FieldModifier.final$
              ..docs.add(
                '/// The original string value from JSON, always available.',
              );
          }),
        );

        // Add constructors
        b.constructors.add(
          cb.Constructor((c) {
            c.docs.add('/// Creates a default constructor.');
            c.optionalParameters
              ..add(
                cb.Parameter((p) {
                  p
                    ..name = 'value'
                    ..type = cb.refer('$enumName?');
                }),
              )
              ..add(
                cb.Parameter((p) {
                  p
                    ..name = 'stringValue'
                    ..type = cb.refer('String?');
                }),
              );
            c.initializers.add(cb.Code('enumValue = value'));
            c.initializers.add(cb.Code('originalValue = stringValue'));
          }),
        );

        b.constructors.add(
          cb.Constructor((c) {
            c.name = 'known';
            c.docs.add('/// Creates a wrapper with a known enum value.');
            c.docs.add('/// ');
            c.docs.add('/// The [value] parameter is the enum value to wrap.');
            c.requiredParameters.add(
              cb.Parameter((p) {
                p
                  ..name = 'value'
                  ..type = cb.refer('$enumName?');
              }),
            );
            c.initializers.add(cb.Code('enumValue = value'));
            c.initializers
                .add(cb.Code('originalValue = _getStringForEnum(value)'));
          }),
        );

        b.constructors.add(
          cb.Constructor((c) {
            c.name = 'unknown';
            c.docs.add('/// Creates a wrapper for an unknown enum value.');
            c.docs.add('/// ');
            c.docs.add(
              '/// The [value] parameter is the original string value that couldn\'t be mapped to a known enum value.',
            );
            c.requiredParameters.add(
              cb.Parameter((p) {
                p
                  ..name = 'value'
                  ..type = cb.refer('String?');
              }),
            );
            c.initializers.add(cb.Code('enumValue = null'));
            c.initializers.add(cb.Code('originalValue = value'));
          }),
        );

        // Add methods
        b.methods.add(
          cb.Method((m) {
            m
              ..name = 'isUnknown'
              ..type = cb.MethodType.getter
              ..returns = cb.refer('bool')
              ..lambda = true
              ..body = cb.Code('enumValue == null')
              ..docs.add(
                '/// Returns true if this wrapper contains an unknown value that couldn\'t be mapped to a known enum value.',
              );
          }),
        );

        b.methods.add(
          cb.Method((m) {
            m
              ..name = 'toJsonValue'
              ..returns = cb.refer('String')
              ..lambda = true
              ..body = cb.Code('originalValue ?? \'UNKNOWN\'')
              ..docs.add(
                '/// Returns the string representation of this enum value for JSON serialization.',
              );
          }),
        );

        // Add operator ==
        b.methods.add(
          cb.Method((m) {
            m.annotations.add(cb.refer('override'));
            m
              ..name = 'operator =='
              ..returns = cb.refer('bool');
            m.requiredParameters.add(
              cb.Parameter((p) {
                p
                  ..name = 'other'
                  ..type = cb.refer('Object');
              }),
            );
            m.body = cb.Code('''
if (identical(this, other)) return true;
return other is ${b.name} &&
    other.enumValue == enumValue &&
    other.originalValue == originalValue;
''');
          }),
        );

        // Add hashCode
        b.methods.add(
          cb.Method((m) {
            m.annotations.add(cb.refer('override'));
            m
              ..name = 'hashCode'
              ..type = cb.MethodType.getter
              ..returns = cb.refer('int')
              ..lambda = true
              ..body = cb.Code('enumValue.hashCode ^ originalValue.hashCode');
          }),
        );

        // Add toString
        b.methods.add(
          cb.Method((m) {
            m.annotations.add(cb.refer('override'));
            m
              ..name = 'toString'
              ..returns = cb.refer('String')
              ..lambda = true
              ..body = cb.Code(
                "'${b.name}(enumValue: \$enumValue, originalValue: \$originalValue)'",
              );
          }),
        );

        // Add _getStringForEnum method
        b.methods.add(
          cb.Method((m) {
            m
              ..name = '_getStringForEnum'
              ..static = true
              ..returns = cb.refer('String?');
            m.requiredParameters.add(
              cb.Parameter((p) {
                p
                  ..name = 'value'
                  ..type = cb.refer('$enumName?');
              }),
            );

            // Build the switch statement for enum values
            final cases = StringBuffer();
            for (final enumValue in enumValues) {
              final jsonString = getJsonStringForEnumValue(
                enumValue,
                explicitJsonValues,
                fieldRenamePolicy,
              );
              cases.writeln('case $enumName.${enumValue.name}:');

              if (enumValue.name.toLowerCase() == 'unknown') {
                cases.writeln('default:');
              }

              cases.writeln('  return "$jsonString";');
            }

            m.body = cb.Code('''
                switch (value) {
                  $cases
                }
            ''');
          }),
        );
      });

  static cb.Code generateTestCode({
    required String enumName,
    required String wrapperClassName,
    required String converterClassName,
    required List<FieldElement> enumValues,
    required Map<String, String> explicitJsonValues,
    FieldRename? fieldRenamePolicy,
  }) =>
      cb.Block((b) {
        b
          ..addExpression(
            cb.Method((m) {
              m
                ..name = '${wrapperClassName}FromJson'
                ..returns = cb.refer(wrapperClassName);

              // Add docs
              m.docs.addAll([
                '/// Converts a JSON string to a [$wrapperClassName].',
                '/// ',
                '/// If the string matches a known enum value, returns a wrapper with that value.',
                '/// Otherwise, returns a wrapper with an unknown value containing the original string.',
              ]);

              m.requiredParameters.add(
                cb.Parameter((p) {
                  p
                    ..name = 'jsonValue'
                    ..type = cb.refer('String?');
                }),
              );

              // Build the if-else chain for enum values
              final conditions = StringBuffer();
              for (final enumValue in enumValues) {
                final jsonString = getJsonStringForEnumValue(
                  enumValue,
                  explicitJsonValues,
                  fieldRenamePolicy,
                );
                conditions
                  ..writeln('if (jsonValue == "$jsonString") {')
                  ..writeln(
                    '  return $wrapperClassName.known($enumName.${enumValue.name});',
                  )
                  ..writeln('}');
              }

              conditions
                  .writeln('return $wrapperClassName.unknown(jsonValue);');

              m.body = cb.Code(conditions.toString());
            }).genericClosure,
          )
          ..addExpression(
            cb.Method((m) {
              m
                ..name = '${wrapperClassName}ToJson'
                ..returns = cb.refer('String');

              // Add docs
              m.docs.addAll([
                '/// Converts a [$wrapperClassName] to a JSON string.',
                '/// ',
                '/// Returns the original string value, whether it was a known enum value or an unknown value.',
              ]);

              m.requiredParameters.add(
                cb.Parameter((p) {
                  p
                    ..name = 'object'
                    ..type = cb.refer(wrapperClassName);
                }),
              );
              m
                ..lambda = true
                ..body = cb.Code('object.toJsonValue()');
            }).genericClosure,
          );
      });

  /// Generates the JsonConverter class for the enum wrapper
  static cb.Class generateConverterClass({
    required String enumName,
    required List<FieldElement> enumValues,
    required Map<String, String> explicitJsonValues,
    FieldRename? fieldRenamePolicy,
  }) =>
      cb.Class((b) {
        b.name = 'A$enumName';
        b.implements.add(cb.refer('JsonConverter<W$enumName?, String?>'));
        b.docs.add(
          '/// A [JsonConverter] that converts between [String] and [W$enumName].',
        );
        b.docs.add('/// ');
        b.docs.add(
          '/// Use this as an annotation on fields in your serializable classes:',
        );
        b.docs.add('/// ```dart');
        b.docs.add('/// @${b.name}()');
        b.docs.add('/// final W$enumName myEnum;');
        b.docs.add('/// ```');

        // Add const constructor
        b.constructors.add(
          cb.Constructor((c) {
            c.constant = true;
            c.docs.add('/// Creates a const instance of [${b.name}].');
          }),
        );

        // Add fromJson method
        b.methods.add(
          cb.Method((m) {
            m.annotations.add(cb.refer('override'));
            m
              ..name = 'fromJson'
              ..returns = cb.refer('W$enumName?');

            // Add docs
            m.docs.addAll([
              '/// Converts a JSON string to a [W$enumName].',
              '/// ',
              '/// If the string matches a known enum value, returns a wrapper with that value.',
              '/// Otherwise, returns a wrapper with an unknown value containing the original string.',
            ]);

            m.requiredParameters.add(
              cb.Parameter((p) {
                p
                  ..name = 'jsonValue'
                  ..type = cb.refer('String?');
              }),
            );

            // Build the if-else chain for enum values
            final conditions = StringBuffer();
            for (final enumValue in enumValues) {
              final jsonString = getJsonStringForEnumValue(
                enumValue,
                explicitJsonValues,
                fieldRenamePolicy,
              );
              conditions
                ..writeln('if (jsonValue == "$jsonString") {')
                ..writeln(
                  '  return W$enumName.known($enumName.${enumValue.name});',
                )
                ..writeln('}');
            }

            conditions.writeln('return W$enumName.unknown(jsonValue);');

            m.body = cb.Code(conditions.toString());
          }),
        );

        // Add toJson method
        b.methods.add(
          cb.Method((m) {
            m.annotations.add(cb.refer('override'));
            m
              ..name = 'toJson'
              ..returns = cb.refer('String');

            // Add docs
            m.docs.addAll([
              '/// Converts a [W$enumName] to a JSON string.',
              '/// ',
              '/// Returns the original string value, whether it was a known enum value or an unknown value.',
            ]);

            m.requiredParameters.add(
              cb.Parameter((p) {
                p
                  ..name = 'object'
                  ..type = cb.refer('W$enumName?');
              }),
            );
            m
              ..lambda = true
              ..body = cb.Code('object?.toJsonValue() ?? \'UNKNOWN\'');
          }),
        );
      });

  static cb.Class generateListConverterClass({
    required String enumName,
    required List<FieldElement> enumValues,
    required Map<String, String> explicitJsonValues,
    FieldRename? fieldRenamePolicy,
  }) =>
      cb.Class((b) {
        b
          ..name = 'AList$enumName'
          ..implements.add(
            cb.refer(
              'JsonConverter<List<W$enumName?>?, List<String?>?>',
            ),
          )
          ..docs.add(
            '/// A [JsonConverter] that converts between [List<String>] and [List<W$enumName>].',
          )
          ..docs.add('/// ')
          ..docs.add(
            '/// Use this as an annotation on fields in your serializable classes:',
          )
          ..docs.add('/// ```dart')
          ..docs.add('/// @${b.name}()')
          ..docs.add('/// final ListW$enumName? myEnum;')
          ..docs.add('/// ```')

          // Add const constructor
          ..constructors.add(
            cb.Constructor((c) {
              c.constant = true;
              c.docs.add(
                '/// Creates a const instance of [${b.name}].',
              );
            }),
          )

          // Add fromJson method
          ..methods.add(
            cb.Method((m) {
              m
                ..annotations.add(cb.refer('override'))
                ..name = 'fromJson'
                ..returns = cb.refer('List<W$enumName?>?')

                // Add docs
                ..docs.addAll([
                  '/// Converts a JSON string list to a [List<W$enumName?>?].',
                  '/// ',
                  '/// If the string matches a known enum value, returns a wrapper with that value.',
                  '/// Otherwise, returns a wrapper with an unknown value containing the original string.',
                ])
                ..requiredParameters.add(
                  cb.Parameter((p) {
                    p
                      ..name = 'jsonValues'
                      ..type = cb.refer('List<String?>?');
                  }),
                )
                ..body = cb.Code(
                  'jsonValues?.map((jsonValue) => const ${b.name?.replaceAll('List', '')}().fromJson(jsonValue)).toList()',
                )
                ..lambda = true;
            }),
          )

          // Add toJson method
          ..methods.add(
            cb.Method((m) {
              m
                ..annotations.add(cb.refer('override'))
                ..name = 'toJson'
                ..returns = cb.refer('List<String?>?')

                // Add docs

                ..docs.addAll([
                  '/// Converts a [List<W$enumName?>?] to a JSON string.',
                  '/// ',
                  '/// Returns the original string value, whether it was a known enum value or an unknown value.',
                ])
                ..requiredParameters.add(
                  cb.Parameter((p) {
                    p
                      ..name = 'objects'
                      ..type = cb.refer('List<W$enumName?>?');
                  }),
                )
                ..lambda = true
                ..body = cb.Code(
                  'objects?.map((wrapper) => wrapper?.toJsonValue()).toList()',
                );
            }),
          );
      });
}
