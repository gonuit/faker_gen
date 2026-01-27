/// Categorizes the different kinds of types that the faker generator supports.
///
/// Each kind has different code generation strategies for:
/// - Random value generation
/// - Type casting from Object?
/// - Validation requirements
enum TypeKind {
  /// Primitive types: String, int, double, num, bool
  primitive,

  /// Dart enum types
  enumType,

  /// DateTime type
  dateTime,

  /// List&lt;T&gt; types
  list,

  /// Set&lt;T&gt; types
  set,

  /// Map&lt;K, V&gt; types
  map,

  /// Classes annotated with @FakeIt()
  fakerClass,

  /// Fields annotated with @FakeWith(customFunction)
  fakeWithFunction,
}
