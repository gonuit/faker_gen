import 'type_info.dart';

/// Holds analyzed field/parameter information for code generation.
///
/// Captures all details needed to generate:
/// - Parameter declarations in the mock function
/// - Value expressions in the constructor call
/// - Sentinel checks for provided vs. not-provided values
final class FieldInfo {
  const FieldInfo({
    required this.name,
    required this.typeDisplayString,
    required this.typeInfo,
    required this.isNullable,
    required this.isRequired,
    required this.isNamed,
    this.fakeAsMethod,
    this.fakeAsArgs,
    this.fakeValue,
    this.hasFakeValue = false,
    this.fakeGeneratorClass,
    this.fakeGeneratorArgs,
  });

  /// The parameter/field name.
  final String name;

  /// The type display string (e.g., "String?", "List&lt;int&gt;").
  final String typeDisplayString;

  /// Analyzed type information for code generation.
  final TypeInfo typeInfo;

  /// Whether the type is nullable (has ? suffix).
  final bool isNullable;

  /// Whether the parameter is required.
  final bool isRequired;

  /// Whether the parameter is named (vs positional).
  final bool isNamed;

  /// The Faker method to use (from @FakeAs annotation), e.g., 'nextEmail'.
  final String? fakeAsMethod;

  /// The arguments to pass to the Faker method, e.g., 'count: 5'.
  final String? fakeAsArgs;

  /// The constant value to use (from @FakeValue annotation).
  /// Use [hasFakeValue] to check if this was set, since null is a valid value.
  final String? fakeValue;

  /// Whether @FakeValue annotation was present (distinguishes null value from no annotation).
  final bool hasFakeValue;

  /// The FakeGenerator subclass name (e.g., 'AuthorGenerator').
  final String? fakeGeneratorClass;

  /// The constructor arguments for the FakeGenerator (e.g., 'min: 1, max: 10').
  final String? fakeGeneratorArgs;
}
