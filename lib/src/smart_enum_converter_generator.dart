import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:smart_enum_converter/src/utils/utils.dart' show Utils;
import 'package:source_gen/source_gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:code_builder/code_builder.dart' as cb;
import 'package:dart_style/dart_style.dart';
import 'package:smart_enum_converter/smart_enum_converter.dart';

/// Generates smart enum converters for enums annotated with [SmartEnumConverter].
class SmartEnumConverterGenerator
    extends GeneratorForAnnotation<SmartEnumConverter> {
  @override
  String? generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    buildStep.trackStage(
        '========================================================================== label ==========================================================================',
        () {
      log.info('Generating code for enum: ${element.name}');
    });
    log
      ..info(
        '==========================================================================',
      )
      ..info('Generating code for enum: ${element.name}')
      ..info('halo ==== Generating code for enum')
      ..info(
        '==========================================================================',
      );

    if (element is! EnumElement) {
      throw InvalidGenerationSourceError(
        '`@SmartEnumConverter` can only be applied to enums. Found on `${element.name}` which is a `${element.kind}`.',
        element: element,
        todo:
            'Remove the @SmartEnumConverter annotation from this element or apply it to a valid enum.',
      );
    }

    final enumElement = element;
    final enumName = enumElement.name;

    // --- Enum Analysis ---

    // 1. Extract Enum Values (Fields)
    // Enum values are fields of the EnumElement
    final enumValues =
        enumElement.fields.where((field) => field.isEnumConstant).toList();

    if (enumValues.isEmpty) {
      throw InvalidGenerationSourceError(
        'Enum `${enumElement.name}` must have at least one value to generate a converter.',
        element: enumElement,
        todo:
            'Add values to the enum `${enumElement.name}` or remove the @SmartEnumConverter annotation.',
      );
    }

    // For debugging or to see what's extracted:
    // print('Enum: $enumName');
    // for (var value in enumValues) {
    //   print('  Value: ${value.name}');
    // }

    // 2. Extract JsonValue annotations and JsonEnum policy
    // Look for @JsonValue annotations on enum constants
    final explicitJsonValues = <String, String>{};
    for (final enumValue in enumValues) {
      final jsonValueAnnotation = Utils.getJsonValueAnnotation(enumValue);
      if (jsonValueAnnotation != null) {
        explicitJsonValues[enumValue.name] = jsonValueAnnotation;
      }
    }

    // Look for @JsonEnum annotation on the enum itself
    FieldRename? fieldRenamePolicy;
    final jsonEnumAnnotation = Utils.getJsonEnumAnnotation(enumElement);
    if (jsonEnumAnnotation != null) {
      fieldRenamePolicy = Utils.getFieldRenamePolicy(jsonEnumAnnotation);
    }

    // Check for duplicate JSON string values
    final Map<String, List<String>> jsonStringsToEnumNames = {};
    for (final enumValue in enumValues) {
      final jsonString = Utils.getJsonStringForEnumValue(
        enumValue,
        explicitJsonValues,
        fieldRenamePolicy,
      );
      jsonStringsToEnumNames
          .putIfAbsent(jsonString, () => [])
          .add(enumValue.name);
    }

    // Check for duplicates
    for (final entry in jsonStringsToEnumNames.entries) {
      if (entry.value.length > 1) {
        throw InvalidGenerationSourceError(
          'Multiple enum values in `${enumElement.name}` map to the same JSON string: "${entry.key}". Conflicting values: ${entry.value.join(', ')}.',
          element: enumElement,
          todo:
              'Ensure each enum value maps to a unique JSON string, either via @JsonValue or fieldRename settings.',
        );
      }
    }

    // Create a library to hold all the generated code
    final library = cb.Library(
      (b) => b
        ..body.add(
          Utils.generateWrapperClass(
            enumName: enumName,
            enumValues: enumValues,
            explicitJsonValues: explicitJsonValues,
            fieldRenamePolicy: fieldRenamePolicy,
          ),
        )

        // Add the converter class
        ..body.add(
          Utils.generateConverterClass(
            enumName: enumName,
            enumValues: enumValues,
            explicitJsonValues: explicitJsonValues,
            fieldRenamePolicy: fieldRenamePolicy,
          ),
        )

        // Add converter class for lists
        ..body.add(
          Utils.generateListConverterClass(
            enumName: enumName,
            enumValues: enumValues,
            explicitJsonValues: explicitJsonValues,
            fieldRenamePolicy: fieldRenamePolicy,
          ),
        ),
        // ..body.add(
        //   Utils.generateTestCode(
        //     enumName: enumName,
        //     wrapperClassName: wrapperClassName,
        //     converterClassName: converterClassName,
        //     enumValues: enumValues,
        //     explicitJsonValues: explicitJsonValues,
        //   ),
        // ),
    );

    // Generate the code
    final emitter = cb.DartEmitter(useNullSafetySyntax: true);
    final generatedCode = library.accept(emitter).toString();

    // Format the code with DartFormatter
    try {
      // Use DartFormatter with required languageVersion parameter
      // Import the Version class from package:pub_semver/pub_semver.dart
      final formatter = DartFormatter(
        pageWidth: 80,
        languageVersion: Version(3, 0, 0),
      );
      return formatter.format(generatedCode);
    } catch (e) {
      // If formatting fails, return the unformatted code
      print('Warning: Failed to format code: $e');
      return generatedCode;
    }
  }
}
