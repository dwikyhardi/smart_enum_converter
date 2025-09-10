/// Support for generating smart enum converters with fallback for unknown values.
///
/// This library provides the [SmartEnumConverter] annotation to trigger
/// code generation for robust enum handling in JSON serialization.
///
/// ## Overview
///
/// When working with APIs, especially those that evolve over time, you may
/// encounter enum values that your client code doesn't recognize. This package
/// helps you handle those cases gracefully by generating wrapper classes that
/// preserve the original string value while still providing type safety for
/// known values.
///
/// ## Usage
///
/// 1. Add the `@SmartEnumConverter()` annotation to your enum
/// 2. Add a part directive for the generated code
/// 3. Run `build_runner` to generate the wrapper and converter classes
/// 4. Use the generated converter in your serializable classes
///
/// See the README for detailed usage examples and configuration options.
library;

export 'src/annotations/annotations.dart';

// Other exports will go here as we build more components.
