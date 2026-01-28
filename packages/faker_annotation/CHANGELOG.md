# Changelog

## 0.3.1

- Fixed `FakeGenerator<T>` example in README (use directly as annotation, not inside `@FakeWith`)

## 0.3.0

- Added `FakeGenerator<T>` abstract class for creating reusable custom generators
- Documentation improvements

## 0.2.0

- Added `@FakeAs.alwaysNull()` annotation for always setting nullable fields to `null`
- Added `@FakeValue()` annotation for setting constant values (primitives and complex objects)

## 0.1.0

- Initial release
- Added `@FakeIt()` annotation for marking classes for fake factory generation
- Added `@FakeAs()` annotation for specifying `Faker` methods to use for fields
- Added `@FakeWith()` annotation for custom fake functions
- Added `Faker` class providing comprehensive fake data generation methods
