# faker_annotation

Annotations and utilities for the [faker_gen](https://pub.dev/packages/faker_gen) code generator. Provides `@FakeIt`, `@FakeAs`, `@FakeWith` annotations and the `Faker` class for generating realistic fake data.

## Installation

```yaml
dependencies:
  faker_annotation: ^0.1.0
```

## Annotations

### @FakeIt

Marks a class for fake factory generation.

```dart
@FakeIt()
class User {
  final String name;
  final int age;
  User({required this.name, required this.age});
}
```

### @FakeAs

Specifies which `Faker` method to use for a field.

```dart
@FakeIt()
class Person {
  @FakeAs.uuid()
  final String id;
  
  @FakeAs.firstName()
  final String name;
  
  @FakeAs.email()
  final String email;
  
  @FakeAs.integer(min: 18, max: 65)
  final int age;
  
  Person({...});
}
```

### @FakeWith

Use a custom function for complex fake data.

```dart
List<String> fakeTags(Faker f) => f.nextListOf(() => f.nextWord(), maxLength: 5);

@FakeIt()
class Article {
  @FakeWith(fakeTags)
  final List<String> tags;
  
  Article({required this.tags});
}
```

## Faker

Generates fake data powered by [faker](https://pub.dev/packages/faker).

```dart
final f = Faker();

// Primitives
f.nextString();
f.nextInt(min: 0, max: 100);
f.nextBool();
f.nextDateTime();
f.nextEnum(Status.values);
f.nextFirstName();
f.nextCity();
f.nextSentence();
// ...
```

## License

MIT
