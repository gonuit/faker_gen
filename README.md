# Faker

A Dart code generator for creating type-safe fake data factories. Annotate your classes and get realistic test data powered by [faker](https://pub.dev/packages/faker).

## Packages

| Package | Description |
|---------|-------------|
| [faker_annotation](packages/faker_annotation) | Annotations (`@FakeIt`, `@FakeAs`, `@FakeWith`) and `Randomizer` |
| [faker_gen](packages/faker_gen) | Code generator for fake factories |

## Quick Start

```yaml
dependencies:
  faker_annotation: ^0.1.0

dev_dependencies:
  faker_gen: ^0.1.0
  build_runner: ^2.4.0
```

```dart
@FakeIt()
class User {
  final String name;
  final int age;
  User({required this.name, required this.age});
}

// Use generated factory
final user = fakeUser();
final users = fakeUser.many(10);
```

```bash
dart run build_runner build
```

## License

MIT
