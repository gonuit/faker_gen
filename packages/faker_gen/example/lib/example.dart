// ignore_for_file: unused_local_variable

/// Example package demonstrating faker_gen usage.
///
/// This example shows how to use `@FakeIt()` and `@FakeAs` annotations
/// to generate fake factory functions for your data models.
library;

import 'package:faker_annotation/faker_annotation.dart';
export 'models/complete_model.dart';

/// Part file for generated code.
part 'example.g.dart';

// ─── Custom Types ────────────────────────────────────────────────────────────

/// A custom class to demonstrate @FakeWith usage.
class Author {
  final String name;
  final String email;

  const Author({required this.name, required this.email});
}

/// Custom fake function for Author - receives Faker instance for data generation.
Author fakeAuthor(Faker f) =>
    Author(name: f.nextFullName(), email: f.nextEmail());

// ─── Custom FakeGenerator ────────────────────────────────────────────────────

/// A reusable, parameterizable generator using FakeGenerator<T>.
///
/// Unlike @FakeWith functions, FakeGenerator allows configuration via
/// constructor parameters, making it more flexible and reusable.
class FakeAuthorGenerator extends FakeGenerator<Author> {
  final String? defaultDomain;
  final String? fixedName;

  const FakeAuthorGenerator({this.defaultDomain, this.fixedName});

  @override
  Author generate(Faker faker) => Author(
        name: fixedName ?? faker.nextFullName(),
        email: defaultDomain != null
            ? '${faker.nextUsername()}@$defaultDomain'
            : faker.nextEmail(),
      );
}

// ─── Model Definition ────────────────────────────────────────────────────────

/// Annotate your model with @FakeIt() to generate a fake factory function.
///
/// After running `dart run build_runner build`, this generates a `fakeUser()`
/// function that creates User instances with realistic fake data.
///
/// Use [seed] for reproducible fake data - same seed = same data every time.
@FakeIt(seed: 42)
class User {
  // ─── String Generators ───────────────────────────────────────────────────

  @FakeAs.uuid()
  final String id;

  @FakeAs.firstName()
  final String firstName;

  @FakeAs.lastName()
  final String lastName;

  @FakeAs.email()
  final String email;

  @FakeAs.username()
  final String username;

  @FakeAs.password(length: 16)
  final String password;

  @FakeAs.integer(min: 18, max: 65)
  final int age;

  @FakeAs.decimal(min: 0.0, max: 100000.0)
  final double salary;

  @FakeAs.city()
  final String city;

  @FakeAs.country()
  final String country;

  @FakeAs.streetAddress()
  final String address;

  @FakeAs.latitude()
  final double latitude;

  @FakeAs.longitude()
  final double longitude;

  @FakeAs.jobTitle()
  final String jobTitle;

  @FakeAs.companyName()
  final String company;

  @FakeAs.phoneNumber()
  final String phone;

  @FakeAs.url()
  final String website;

  @FakeAs.dateTime()
  final DateTime createdAt;

  @FakeAs.dateTime(minYear: 1980, maxYear: 2005)
  final DateTime birthDate;

  @FakeAs.sentence()
  final String bio;

  @FakeAs.words(count: 3)
  final List<String> tags;

  /// Use @FakeWith to provide a custom generator function.
  @FakeWith(fakeAuthor)
  final Author createdBy;

  /// Use @FakeValue to provide a constant object value.
  @FakeValue(Author(name: 'System', email: 'system@example.com'))
  final Author editedBy;

  /// Use FakeGenerator<T> for reusable, parameterizable generators.
  /// Here we configure it to always use 'company.com' domain.
  @FakeAuthorGenerator(defaultDomain: 'company.com')
  final Author reviewer;

  /// Use @FakeValue to provide a constant value.
  @FakeValue('2.0.0')
  final String appVersion;

  /// Use @FakeAs.alwaysNull() for optional fields that should be null.
  @FakeAs.alwaysNull()
  final DateTime? deletedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
    required this.age,
    required this.salary,
    required this.city,
    required this.country,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.jobTitle,
    required this.company,
    required this.phone,
    required this.website,
    required this.createdAt,
    required this.birthDate,
    required this.bio,
    required this.tags,
    required this.createdBy,
    required this.editedBy,
    required this.reviewer,
    required this.appVersion,
    this.deletedAt,
  });
}

// ─── Usage ───────────────────────────────────────────────────────────────────

void main() {
  // After running build_runner, use the generated `fakeUser()` function:
  final user = fakeUser();

  print('Generated User:');
  // ID: e4d58fd0-8f43-3da7-97e4-af0a4e00584f
  print('  ID: ${user.id}');
  // Name: Nasir Lesch
  print('  Name: ${user.firstName} ${user.lastName}');
  // Email: paucek_eduardo@parisian.info
  print('  Email: ${user.email}');
  // Username: collins-evans
  print('  Username: ${user.username}');
  // Age: 62
  print('  Age: ${user.age}');
  // Salary: $79872.77
  print('  Salary: \$${user.salary.toStringAsFixed(2)}');
  // Job: Forward Metrics Developer at Kuhlman Inc
  print('  Job: ${user.jobTitle} at ${user.company}');
  // Location: 605016 Lori Wall, Leannafort, Northern Mariana Islands
  print('  Location: ${user.address}, ${user.city}, ${user.country}');
  // Coordinates: (89.64007325639838, 60.00145678539363)
  print('  Coordinates: (${user.latitude}, ${user.longitude})');
  // Phone: 285-608-5810
  print('  Phone: ${user.phone}');
  // Website: https://schneider.us
  print('  Website: ${user.website}');
  // Bio: Fringilla urna porttitor rhoncus dolor purus non enim praesent elementum.
  print('  Bio: ${user.bio}');
  // Tags: dui, vel, etiam
  print('  Tags: ${user.tags.join(", ")}');
  // Created: 2001-02-18 19:01:56.776365
  print('  Created: ${user.createdAt}');
  // Birth Date: 1994-06-23 06:33:14.968941
  print('  Birth Date: ${user.birthDate}');
  // Created By: Stephania Gusikowski (kreiger-cortez@thompson.co.uk)
  print('  Created By: ${user.createdBy.name} (${user.createdBy.email})');
  // Edited By: System (system@example.com)
  print('  Edited By: ${user.editedBy.name} (${user.editedBy.email})');
  // Reviewer: Marcus Johnson (johnson-marcus@company.com) - uses FakeGenerator
  print('  Reviewer: ${user.reviewer.name} (${user.reviewer.email})');
  // App Version: 2.0.0
  print('  App Version: ${user.appVersion}');
  // Deleted At: null
  print('  Deleted At: ${user.deletedAt}');
}
