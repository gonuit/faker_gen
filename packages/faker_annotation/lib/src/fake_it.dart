import 'package:meta/meta_meta.dart';

/// Annotation to mark a class for fake factory function generation.
///
/// When applied to a class, the faker generator will create a `fakeClassName()`
/// function that instantiates the class with random values for all fields.
///
/// ## Basic Usage
///
/// ```dart
/// import 'package:faker_annotation/faker_annotation.dart';
///
/// part 'user.fake.dart';
///
/// @FakeIt()
/// class User {
///   final String id;
///   final String name;
///   final int? age;
///
///   User({required this.id, required this.name, this.age});
/// }
/// ```
///
/// ## Generated Function
///
/// The generator creates a function following the "freezed-style" pattern:
/// - All parameters are optional with `Object?` type
/// - Not provided = random value generated
/// - Explicitly passed value = that value is used
/// - Explicitly passed `null` = null is set (for nullable fields)
///
/// ```dart
/// // Generated fakeUser function usage:
/// fakeUser();                          // All random
/// fakeUser(id: 'custom-id');           // Custom id, rest random
/// fakeUser(age: null);                 // age is null, rest random
/// ```
///
/// ## Nested Types
///
/// For fields that reference other classes, those classes must also be
/// annotated with `@FakeIt()`. The generator will fail the build if a
/// nested complex type is not annotated.
///
/// ## Randomizer
///
/// The generated code uses the `Randomizer` class from the foundation package
/// to generate random values. You can pass a `Randomizer` instance to the
/// generated function for reproducible results:
///
/// ```dart
/// final randomizer = Randomizer(seed: 42);
/// final user1 = fakeUser(randomizer: randomizer);
/// final user2 = fakeUser(randomizer: Randomizer(seed: 42));
/// // user1 and user2 will have the same random values
/// ```
@Target({TargetKind.classType})
class FakeIt {
  /// Creates a [FakeIt] annotation.
  ///
  /// [seed] - Optional seed for the Faker's random number generator.
  /// When set, generates reproducible fake data. If null, random values
  /// are generated each time.
  ///
  /// [generateNullForNullable] - If true, nullable fields have a chance to be
  /// null when not explicitly provided. Defaults to true.
  ///
  /// [nullProbability] - The probability (0.0 to 1.0) that a nullable field
  /// will be null when [generateNullForNullable] is true. Defaults to 0.3.
  const FakeIt({
    this.seed,
    this.generateNullForNullable = true,
    this.nullProbability = 0.3,
  });

  /// Optional seed for reproducible fake data generation.
  final int? seed;

  /// Whether to randomly generate null for nullable fields.
  final bool generateNullForNullable;

  /// The probability that a nullable field will be null.
  final double nullProbability;
}

/// Shorthand constant for `@FakeIt()` annotation.
const fakeIt = FakeIt();
