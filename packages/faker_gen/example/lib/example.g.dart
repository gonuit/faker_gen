// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// FakerGenerator
// **************************************************************************

// ignore_for_file: unused_element
// ignore_for_file: library_private_types_in_public_api

/// Creates a fake instance of [User] with random or provided values.
///
/// All parameters are optional:
/// - Not provided: A random value is generated
/// - Explicitly provided: The provided value is used
/// - Explicitly null (for nullable fields): null is set
///
/// [faker] - Optional [Faker] instance for reproducible random values.
abstract class _$FakeUser {
  User call({
    Faker? faker,
    String id,
    String firstName,
    String lastName,
    String email,
    String username,
    String password,
    int age,
    double salary,
    String city,
    String country,
    String address,
    double latitude,
    double longitude,
    String jobTitle,
    String company,
    String phone,
    String website,
    DateTime createdAt,
    DateTime birthDate,
    String bio,
    List<String> tags,
    Author createdBy,
    Author editedBy,
    Author reviewer,
    String appVersion,
    DateTime? deletedAt,
  });

  /// Generates [count] fake instances of [User].
  Iterable<User> many(int count, {Faker? faker});
}

class _$FakeUserImpl implements _$FakeUser {
  const _$FakeUserImpl();

  @override
  User call({
    Faker? faker,
    Object id = $undefined,
    Object firstName = $undefined,
    Object lastName = $undefined,
    Object email = $undefined,
    Object username = $undefined,
    Object password = $undefined,
    Object age = $undefined,
    Object salary = $undefined,
    Object city = $undefined,
    Object country = $undefined,
    Object address = $undefined,
    Object latitude = $undefined,
    Object longitude = $undefined,
    Object jobTitle = $undefined,
    Object company = $undefined,
    Object phone = $undefined,
    Object website = $undefined,
    Object createdAt = $undefined,
    Object birthDate = $undefined,
    Object bio = $undefined,
    Object tags = $undefined,
    Object createdBy = $undefined,
    Object editedBy = $undefined,
    Object reviewer = $undefined,
    Object appVersion = $undefined,
    Object? deletedAt = $undefined,
  }) {
    final f = faker ?? Faker(seed: 42);

    return User(
      id: identical(id, $undefined) ? f.nextUuid() : id as String,
      firstName:
          identical(firstName, $undefined)
              ? f.nextFirstName()
              : firstName as String,
      lastName:
          identical(lastName, $undefined)
              ? f.nextLastName()
              : lastName as String,
      email: identical(email, $undefined) ? f.nextEmail() : email as String,
      username:
          identical(username, $undefined)
              ? f.nextUsername()
              : username as String,
      password:
          identical(password, $undefined)
              ? f.nextPassword(length: 16)
              : password as String,
      age:
          identical(age, $undefined) ? f.nextInt(min: 18, max: 65) : age as int,
      salary:
          identical(salary, $undefined)
              ? f.nextDouble(min: 0.0, max: 100000.0)
              : (salary as num).toDouble(),
      city: identical(city, $undefined) ? f.nextCity() : city as String,
      country:
          identical(country, $undefined) ? f.nextCountry() : country as String,
      address:
          identical(address, $undefined)
              ? f.nextStreetAddress()
              : address as String,
      latitude:
          identical(latitude, $undefined)
              ? f.nextLatitude()
              : (latitude as num).toDouble(),
      longitude:
          identical(longitude, $undefined)
              ? f.nextLongitude()
              : (longitude as num).toDouble(),
      jobTitle:
          identical(jobTitle, $undefined)
              ? f.nextJobTitle()
              : jobTitle as String,
      company:
          identical(company, $undefined)
              ? f.nextCompanyName()
              : company as String,
      phone:
          identical(phone, $undefined) ? f.nextPhoneNumber() : phone as String,
      website: identical(website, $undefined) ? f.nextUrl() : website as String,
      createdAt:
          identical(createdAt, $undefined)
              ? f.nextDateTime(minYear: 2000, maxYear: 2030)
              : createdAt as DateTime,
      birthDate:
          identical(birthDate, $undefined)
              ? f.nextDateTime(minYear: 1980, maxYear: 2005)
              : birthDate as DateTime,
      bio: identical(bio, $undefined) ? f.nextSentence() : bio as String,
      tags:
          identical(tags, $undefined)
              ? f.nextWords(count: 3)
              : tags as List<String>,
      createdBy:
          identical(createdBy, $undefined)
              ? fakeAuthor(f)
              : createdBy as Author,
      editedBy:
          identical(editedBy, $undefined)
              ? Author(name: 'System', email: 'system@example.com')
              : editedBy as Author,
      reviewer:
          identical(reviewer, $undefined)
              ? const FakeAuthorGenerator(
                defaultDomain: 'company.com',
              ).generate(f)
              : reviewer as Author,
      appVersion:
          identical(appVersion, $undefined) ? '2.0.0' : appVersion as String,
      deletedAt:
          identical(deletedAt, $undefined) ? null : deletedAt as DateTime?,
    );
  }

  @override
  Iterable<User> many(int count, {Faker? faker}) {
    return Iterable.generate(count, (_) => call(faker: faker));
  }
}

/// Fake factory for [User].
///
/// Use like a function: `fakeUser()` or `fakeUser(field: value)`
const _$FakeUser fakeUser = _$FakeUserImpl();
