/// Constants for supported type names to avoid magic strings.
abstract final class SupportedTypes {
  /// Set of primitive type names that can be randomly generated.
  static const primitives = {'String', 'int', 'double', 'num', 'bool'};

  /// DateTime type name.
  static const dateTime = 'DateTime';

  /// Object type name (requires @FakeWith).
  static const object = 'Object';

  /// Dynamic type name (requires @FakeWith).
  static const dynamic_ = 'dynamic';

  /// Checks if [typeName] is a supported primitive type.
  static bool isPrimitive(String typeName) => primitives.contains(typeName);

  /// Checks if [typeName] requires @FakeWith annotation.
  static bool requiresFakeWith(String typeName) =>
      typeName == object || typeName == dynamic_;
}
