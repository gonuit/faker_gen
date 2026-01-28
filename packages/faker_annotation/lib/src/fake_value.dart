import 'package:meta/meta_meta.dart';

/// Annotation to specify a constant value for a field.
///
/// Use this annotation on fields that should always have a specific value
/// in the generated fake instances.
///
/// The value must be a compile-time constant.
///
/// ## Example
///
/// ```dart
/// @FakeIt()
/// class Config {
///   @FakeValue('production')
///   final String environment;
///
///   @FakeValue(42)
///   final int maxRetries;
///
///   @FakeValue(true)
///   final bool enabled;
///
///   @FakeValue(null)
///   final String? optionalField;
///
///   Config({
///     required this.environment,
///     required this.maxRetries,
///     required this.enabled,
///     this.optionalField,
///   });
/// }
/// ```
///
/// The generated fake function will always use the specified values
/// for these fields (unless overridden when calling the fake function).
@Target({TargetKind.field, TargetKind.parameter})
class FakeValue {
  /// Creates a [FakeValue] annotation.
  ///
  /// [value] - The constant value to use for this field.
  const FakeValue(this.value);

  /// The constant value to use for generating fake instances.
  final Object? value;
}
