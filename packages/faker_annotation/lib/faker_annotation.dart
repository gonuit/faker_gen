/// Annotations for the faker code generator.
///
/// Use `@FakeIt()` annotation on classes to generate fake factory functions.
///
/// Example:
/// ```dart
/// import 'package:faker_annotation/faker_annotation.dart';
///
/// part 'user.g.dart';
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
/// After running build_runner, a `fakeUser()` function will be generated
/// using the freezed-style pattern with an abstract interface for type hints:
/// ```dart
/// // Abstract interface provides type hints in IDE
/// abstract class _$FakeUser {
///   User call({Faker? faker, String? id, String? name, int? age});
/// }
///
/// // Implementation uses sentinel pattern for undefined detection
/// class _$FakeUserImpl implements _$FakeUser {
///   User call({Faker? faker, Object? id = _sentinel, ...}) { ... }
/// }
///
/// // Top-level constant for easy usage
/// const _$FakeUser fakeUser = _$FakeUserImpl();
/// ```
///
/// Usage:
/// - `fakeUser()` - all fields get random values
/// - `fakeUser(id: 'custom-id')` - id is 'custom-id', others are random
/// - `fakeUser(age: null)` - age is explicitly null, others are random
library;

export 'src/fake_as.dart';
export 'src/fake_it.dart';
export 'src/fake_with.dart';
export 'src/faker.dart';
export 'src/undefined.dart';
