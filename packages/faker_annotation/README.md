# faker_annotation

Annotations and utilities for the [faker_gen](https://pub.dev/packages/faker_gen) code generator. Provides `@FakeIt`, `@FakeAs`, `@FakeWith` annotations and the `Faker` class for generating realistic fake data.

## Installation

```yaml
dependencies:
  faker_annotation: ^0.3.1
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

### @FakeValue

Use a constant value for a field.

```dart
@FakeIt()
class Config {
  @FakeValue('production')
  final String environment;
  
  @FakeValue(42)
  final int maxRetries;
  
  Config({required this.environment, required this.maxRetries});
}
```

### FakeGenerator<T>

Create reusable, parameterizable generators by extending `FakeGenerator<T>`.

```dart
class FakeAuthorGenerator extends FakeGenerator<Author> {
  final String? defaultDomain;
  const FakeAuthorGenerator({this.defaultDomain});
  
  @override
  Author generate(Faker faker) => Author(
    name: faker.nextFullName(),
    email: defaultDomain != null
        ? '${faker.nextUsername()}@$defaultDomain'
        : faker.nextEmail(),
  );
}

@FakeIt()
class Article {
  @FakeAuthorGenerator(defaultDomain: 'company.com')
  final Author author;
  
  Article({required this.author});
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
