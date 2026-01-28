import 'faker.dart';

/// Abstract class for creating custom fake data generators.
///
/// Extend this class to create reusable fake generators for custom types.
/// The generator can then be used as an annotation on fields.
///
/// ## Example
///
/// ```dart
/// // 1. Create a custom generator
/// class AuthorGenerator extends FakeGenerator<Author> {
///   const AuthorGenerator();
///
///   @override
///   Author generate(Faker faker) => Author(
///     name: faker.nextFullName(),
///     email: faker.nextEmail(),
///   );
/// }
///
/// // 2. Use it as an annotation on a field
/// @FakeIt()
/// class Article {
///   final String title;
///
///   @AuthorGenerator()
///   final Author author;
///
///   Article({required this.title, required this.author});
/// }
/// ```
///
/// ## Benefits over @FakeWith
///
/// - **Reusable**: Define once, use everywhere
/// - **Parameterizable**: Add constructor parameters for configuration
/// - **Self-documenting**: The class name describes what it generates
/// - **Testable**: Can be unit tested independently
///
/// ## Parameterized Example
///
/// ```dart
/// class BoundedIntGenerator extends FakeGenerator<int> {
///   final int min;
///   final int max;
///
///   const BoundedIntGenerator({this.min = 0, this.max = 100});
///
///   @override
///   int generate(Faker faker) => faker.nextInt(min: min, max: max);
/// }
///
/// @FakeIt()
/// class Player {
///   @BoundedIntGenerator(min: 1, max: 99)
///   final int jerseyNumber;
///
///   @BoundedIntGenerator(min: 18, max: 45)
///   final int age;
///
///   Player({required this.jerseyNumber, required this.age});
/// }
/// ```
abstract class FakeGenerator<T> {
  /// Creates a [FakeGenerator].
  const FakeGenerator();

  /// Generates a fake instance of [T].
  ///
  /// Override this method to provide custom fake data generation logic.
  /// The [faker] parameter provides access to all fake data generators.
  T generate(Faker faker);
}
