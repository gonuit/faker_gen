# Changelog

## 0.3.2
- Updated package dependencies

## 0.3.1

- Fixed `FakeGenerator<T>` example in README
- Changed generated fake interface from `abstract mixin class` to `abstract class`
- Changed implementation class to use `implements` instead of `with`
- Added explicit type annotation to factory constant declaration
- Added `library_private_types_in_public_api` lint ignore to generated files

## 0.3.0

- Added `FakeGenerator<T>` abstract class for reusable, parameterizable custom generators

## 0.2.0

- Added support for `@FakeAs.alwaysNull()` to always set nullable fields to `null`
- Added support for `@FakeValue()` annotation for constant values
  - Works with primitives (`String`, `int`, `bool`, etc.)
  - Works with complex objects (e.g., `@FakeValue(Author(name: 'System', email: 'x@y.com'))`)
- Added class hierarchy search for annotations
- Annotations on constructor parameters are now supported

## 0.1.0

- Initial release
- Code generator for `@FakeIt()` annotated classes
- Generates `fakeClassName()` factory functions with optional parameter overrides
- Support for `@FakeAs()` to customize field generation using `Faker` methods
- Support for `@FakeWith()` for custom fake functions
- Support for nested classes and complex type hierarchies
- Support for primitive types, collections (`List`, `Set`, `Map`), and nullable types
