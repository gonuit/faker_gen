# faker_gen

A code generator for creating fake data factories in Dart. Annotate your classes with `@FakeIt()` and get type-safe fake object builders with realistic data powered by [faker](https://pub.dev/packages/faker).

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  faker_annotation: ^0.1.0

dev_dependencies:
  faker_gen: ^0.1.0
  build_runner: ^2.4.0
```

## Basic Usage

```dart
import 'package:faker_annotation/faker_annotation.dart';

part 'user.faker.g.dart';

@FakeIt()
class User {
  final String name;
  final int age;
  final bool active;
  
  User({required this.name, required this.age, required this.active});
}
```

Run the generator:

```bash
dart run build_runner build
```

Use the generated factory:

```dart
// Create a fake user with random data
final user = fakeUser();

// Override specific fields
final customUser = fakeUser(name: 'John', age: 30);

// Generate multiple instances
final users = fakeUser.many(10);
```

## Annotations

### @FakeIt

Marks a class for fake factory generation.

```dart
@FakeIt()
class Product {
  final String id;
  final double price;
  Product({required this.id, required this.price});
}
```

### @FakeAs

Generates semantically meaningful fake data for fields.

```dart
@FakeIt()
class Person {
  @FakeAs.uuid()
  final String id;
  
  @FakeAs.firstName()
  final String name;
  
  @FakeAs.email()
  final String email;
  
  @FakeAs.latitude()
  final double lat;
  
  @FakeAs.integer(min: 18, max: 65)
  final int age;
  
  @FakeAs.dateTime(minYear: 1990, maxYear: 2000)
  final DateTime birthDate;
  
  Person({...});
}
```

### @FakeWith

Use a custom function for complex/custom fake data:

```dart
List<String> fakeTags(Faker f) => f.nextListOf(() => f.nextWord(), maxLength: 5);
dynamic fakeData(Faker f) => f.nextInt();

@FakeIt()
class Article {
  final String title;
  
  @FakeWith(fakeTags)
  final List<String> tags;

  @FakeWith(fakeData)
  final dynamic data;
  
  Article({required this.title, required this.tags, this.data});
}
```

## Faker

The `Faker` class provides all fake data methods. Use it in `@FakeWith` functions or standalone:

```dart
final f = Faker();

f.nextString();           // Random string
f.nextInt(min: 0, max: 100);  // Random int in range
f.nextDouble();           // Random double 0.0-1.0
f.nextBool();             // Random boolean
f.nextDateTime();         // Random DateTime
f.nextEmail();            // Fake email
f.nextFirstName();        // Fake first name
// ...
```

## Nested Classes

Classes annotated with `@FakeIt()` are automatically composed:

```dart
@FakeIt()
class Address {
  final String city;
  Address({required this.city});
}

@FakeIt()
class Company {
  final String name;
  final Address address;  // Automatically uses fakeAddress()
  Company({required this.name, required this.address});
}
```

## License

MIT
