# smart_enum_converter

A Dart code generator that creates robust, custom JsonConverter classes for your enums.
It helps you gracefully handle unknown enum values coming from APIs by preserving the
original string while still giving you strong typing for known values. Works with
json_serializable and build_runner.

## Overview

When APIs add new enum values, older clients can break or lose information. This package
solves that by generating:

- A wrapper type (W<YourEnum>) that carries either the known enum value or the original string
- JsonConverter classes (A<YourEnum> and AList<YourEnum>) you can annotate fields with

This lets you deserialize safely, detect unknowns, keep original values for logging or
forwarding, and serialize back consistently.

## Tech Stack / Detection

- Language: Dart (SDK >= 3.0.0)
- Package manager: dart pub
- Code generation: build_runner, source_gen
- Serialization helpers: json_annotation
- Code emission/formatting: code_builder, dart_style
- Analyzer: analyzer (for reading enum metadata)
- Builder config: build.yaml (outputs .smart.dart parts)

## Requirements

- Dart SDK: ">=3.0.0 <4.0.0"

If you use this in a Flutter project, any recent stable Flutter that bundles a compatible Dart
SDK should work too.

## Installation

Add dependencies to your app or package:

```yaml
dependencies:
  json_annotation: ^4.9.0

dev_dependencies:
  build_runner: ^2.4.15
  json_serializable: ^6.9.5 # optional but commonly used together
  smart_enum_converter: ^0.0.1
```

Then fetch packages:

```bash
dart pub get
```

Note: Because this package provides only annotations and generators for your code, having it
as a dev_dependency is sufficient for most consumers (similar to json_serializable). The
json_annotation runtime dependency remains a normal dependency.

## Usage

### 1) Annotate your enum

Make sure the file has a part directive that ends with `.smart.dart` (this package’s builder
emits that extension).

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_enum_converter/smart_enum_converter.dart';

part 'status.smart.dart';

@SmartEnumConverter()
@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum Status {
  pending,
  inProgress,
  completed,
  failed,
  @JsonValue('custom_cancelled')
  cancelled,
}
```

### 2) Use the generated converter on your model

Two converters are generated per enum:
- `AStatus` for single values
- `AListStatus` for lists

They implement `JsonConverter` and can be used as annotations.

```dart
import 'package:json_annotation/json_annotation.dart';
import 'status.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final String id;

  @AStatus() // Generated for Status enum
  final WStatus? status;

  @AListStatus()
  final List<WStatus?>? statuses;

  Task({required this.id, this.status, this.statuses});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
```

### 3) Run build_runner

```bash
dart run build_runner build --delete-conflicting-outputs
# or keep it running
# dart run build_runner watch --delete-conflicting-outputs
```

### 4) Work with the wrapper

```dart
void process(Task t) {
  final w = t.status; // WStatus?
  if (w == null) return;

  if (w.isUnknown) {
    // Unknown string encountered; preserved for diagnostics or passthrough
    print('Unknown: ${w.originalValue}');
  } else {
    // Known enum value
    final Status s = w.enumValue!;
    print('Known: $s');
  }
}
```

## Generated API (per enum `YourEnum`)

- Wrapper: `WYourEnum`
  - `YourEnum? enumValue`
  - `String? originalValue`
  - `bool get isUnknown`
  - Constructors: `WYourEnum()`, `WYourEnum.known(YourEnum? value)`, `WYourEnum.unknown(String value)`
  - `String toJsonValue()` (returns the string value to serialize)
- Converters:
  - `AYourEnum` implements `JsonConverter<WYourEnum?, String?>`
  - `AListYourEnum` implements `JsonConverter<List<WYourEnum?>?, List<String?>?>`

Note:
- Unknown handling respects `@JsonValue` on members and `@JsonEnum(fieldRename: ...)` on the enum.
- Supported `FieldRename` values include: none, kebab, snake, pascal, screamingSnake.

## Configuration

Just annotate your enum with `@SmartEnumConverter()`.
The generator automatically detects:
- Custom string values via `@JsonValue('...')`
- Enum-wide naming via `@JsonEnum(fieldRename: ...)`

## Example project

This repository includes a runnable example that demonstrates the generated types and converters:

- Files: `example/lib/payment_type.dart`, `example/lib/payment.dart`, `example/lib/usage_example.dart`
- Run it with:

```bash
dart run example/lib/usage_example.dart
```

## Scripts & Commands

Common tasks:

- Install deps
  - `dart pub get`
- Generate once
  - `dart run build_runner build --delete-conflicting-outputs`
- Generate continuously
  - `dart run build_runner watch --delete-conflicting-outputs`
- Run example
  - `dart run example/lib/usage_example.dart`
- Run tests
  - `dart test` (see Testing section)

You can add aliases to your own project’s tooling (e.g., Makefile, npm scripts) if desired.

## Environment Variables

- None required.
- TODO: Document here if future features introduce configuration via env vars.

## Testing

The package depends on the `test` package; however, there are currently no test files in `test/`.

- Run tests when they are added:

```bash
dart test
```

- TODO: Add unit tests covering generator output and unknown handling.

## Project Structure

Key files and directories:

- `lib/smart_enum_converter.dart` – Public library export (annotations)
- `lib/builder.dart` – Builder entry used by build_runner/source_gen
- `lib/src/annotations/annotations.dart` – `SmartEnumConverter` annotation
- `lib/src/smart_enum_converter_generator.dart` – Source_gen generator
- `lib/src/utils/` – Helper utilities used by the generator
- `lib/src/transformer/` – String transformation helpers
- `build.yaml` – Builder configuration (emits `.smart.dart` parts)
- `example/` – Runnable example with generated code
- `test/` – (Currently empty) tests go here

## Entry Points

For consumers:
- Import annotations from: `package:smart_enum_converter/smart_enum_converter.dart`

For build system:
- Builder import: `package:smart_enum_converter/builder.dart`
- Builder factory: `smartEnumConverterBuilder`
- Output extension: `.smart.dart`
- Builder key in build.yaml: `smart_enum_converter`

## Changelog

See [CHANGELOG.md](./CHANGELOG.md).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

The README states that this project uses the MIT License.

- TODO: Add a `LICENSE` file at the repository root to formalize the license, or update this
  section if a different license is intended.