import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:faker_gen/builder.dart';
import 'package:test/test.dart';

/// Inline source for faker_annotation to make it available to testBuilder.
/// This avoids the need for complex package resolution in tests.
const _fakeItSource = r'''
class FakeIt {
  const FakeIt({
    this.generateNullForNullable = true,
    this.nullProbability = 0.3,
  });
  final bool generateNullForNullable;
  final double nullProbability;
}

const fakeIt = FakeIt();

class FakeWith {
  const FakeWith(this.fakeFunction);
  final Function fakeFunction;
}

class Faker {
  Faker([int? seed]);
  String nextString() => '';
  int nextInt() => 0;
  double nextDouble() => 0.0;
  num nextNum() => 0;
  bool nextBool() => false;
  DateTime nextDateTime() => DateTime.now();
  T nextEnum<T>(List<T> values) => values.first;
  List<T> nextListOf<T>(T Function() generator) => [];
  T? nextNullable<T>(T Function() generator, {double nullWeight = 0.5}) => null;
}

/// A sentinel value used to distinguish "not provided" from "explicitly null".
const Object $undefined = _Undefined();

class _Undefined {
  const _Undefined();
}
''';

/// Matcher that decodes bytes to string and checks if it contains the given pattern.
Matcher decodedContains(String pattern) => decodedMatches(contains(pattern));

/// Matcher that decodes bytes to string and checks multiple patterns.
Matcher decodedContainsAll(List<String> patterns) =>
    decodedMatches(allOf(patterns.map(contains).toList()));

void main() {
  group('FakerGenerator integration tests', () {
    group('primitive types', () {
      test('generates fake for class with String field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/user.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class User {
  final String name;
  User({required this.name});
}
''',
          },
          outputs: {
            'a|lib/user.faker.g.part': decodedContainsAll([
              r'$undefined', // shared sentinel
              r'abstract mixin class _$FakeUser',
              r'class _$FakeUserImpl',
              'const fakeUser = _\$FakeUserImpl()',
              'f.nextString()',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('generates fake for class with int field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/counter.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Counter {
  final int count;
  Counter({required this.count});
}
''',
          },
          outputs: {
            'a|lib/counter.faker.g.part': decodedContains('f.nextInt()'),
          },
          rootPackage: 'a',
        );
      });

      test('generates fake for class with double field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/measurement.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Measurement {
  final double value;
  Measurement({required this.value});
}
''',
          },
          outputs: {
            'a|lib/measurement.faker.g.part': decodedContainsAll([
              'f.nextDouble()',
              '(value as num).toDouble()',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('generates fake for class with bool field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/flag.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Flag {
  final bool enabled;
  Flag({required this.enabled});
}
''',
          },
          outputs: {'a|lib/flag.faker.g.part': decodedContains('f.nextBool()')},
          rootPackage: 'a',
        );
      });

      test('generates fake for class with multiple primitive fields', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/person.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Person {
  final String name;
  final int age;
  final bool active;
  Person({required this.name, required this.age, required this.active});
}
''',
          },
          outputs: {
            'a|lib/person.faker.g.part': decodedContainsAll([
              'f.nextString()',
              'f.nextInt()',
              'f.nextBool()',
              'name:',
              'age:',
              'active:',
            ]),
          },
          rootPackage: 'a',
        );
      });
    });

    group('nullable fields', () {
      test(
        'generates fake with nullable handling when generateNullForNullable is true',
        () async {
          await testBuilder(
            fakerBuilder(BuilderOptions.empty),
            {
              'a|lib/faker_annotation.dart': _fakeItSource,
              'a|lib/profile.dart': r'''
import 'faker_annotation.dart';

@FakeIt(generateNullForNullable: true, nullProbability: 0.3)
class Profile {
  final String? bio;
  Profile({this.bio});
}
''',
            },
            outputs: {
              'a|lib/profile.faker.g.part': decodedContainsAll([
                'f.nextNullable',
                'nullWeight: 0.3',
              ]),
            },
            rootPackage: 'a',
          );
        },
      );

      test(
        'generates fake without nullable handling when generateNullForNullable is false',
        () async {
          await testBuilder(
            fakerBuilder(BuilderOptions.empty),
            {
              'a|lib/faker_annotation.dart': _fakeItSource,
              'a|lib/profile.dart': r'''
import 'faker_annotation.dart';

@FakeIt(generateNullForNullable: false)
class Profile {
  final String? bio;
  Profile({this.bio});
}
''',
            },
            outputs: {
              'a|lib/profile.faker.g.part': decodedContains('f.nextString()'),
            },
            rootPackage: 'a',
          );
        },
      );
    });

    group('DateTime', () {
      test('generates fake for class with DateTime field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/event.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Event {
  final DateTime timestamp;
  Event({required this.timestamp});
}
''',
          },
          outputs: {
            'a|lib/event.faker.g.part': decodedContains('f.nextDateTime()'),
          },
          rootPackage: 'a',
        );
      });
    });

    group('List types', () {
      test('generates fake for class with List<String> field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/tags.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Tags {
  final List<String> values;
  Tags({required this.values});
}
''',
          },
          outputs: {
            'a|lib/tags.faker.g.part': decodedContainsAll([
              'f.nextListOf',
              'f.nextString()',
              'values as List<String>',
            ]),
          },
          rootPackage: 'a',
        );
      });
    });

    group('Map types', () {
      test('generates fake for class with Map<String, int> field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/scores.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Scores {
  final Map<String, int> values;
  Scores({required this.values});
}
''',
          },
          outputs: {
            'a|lib/scores.faker.g.part': decodedContainsAll([
              'Map.fromEntries',
              'MapEntry',
              'f.nextString()',
              'f.nextInt()',
              'values as Map<String, int>',
            ]),
          },
          rootPackage: 'a',
        );
      });
    });

    group('Set types', () {
      test('generates fake for class with Set<String> field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/unique_tags.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class UniqueTags {
  final Set<String> tags;
  UniqueTags({required this.tags});
}
''',
          },
          outputs: {
            'a|lib/unique_tags.faker.g.part': decodedContainsAll([
              'f.nextListOf',
              'f.nextString()',
              '.toSet()',
              'tags as Set<String>',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('generates fake for class with Set<int> field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/unique_ids.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class UniqueIds {
  final Set<int> ids;
  UniqueIds({required this.ids});
}
''',
          },
          outputs: {
            'a|lib/unique_ids.faker.g.part': decodedContainsAll([
              'f.nextListOf',
              'f.nextInt()',
              '.toSet()',
            ]),
          },
          rootPackage: 'a',
        );
      });
    });

    group('enum types', () {
      test('generates fake for class with enum field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/status.dart': r'''
import 'faker_annotation.dart';

enum Status { active, inactive, pending }

@FakeIt()
class Task {
  final Status status;
  Task({required this.status});
}
''',
          },
          outputs: {
            'a|lib/status.faker.g.part': decodedContainsAll([
              'f.nextEnum(Status.values)',
              'status as Status',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('generates fake for class with nullable enum field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/status.dart': r'''
import 'faker_annotation.dart';

enum Priority { low, medium, high }

@FakeIt()
class Task {
  final Priority? priority;
  Task({this.priority});
}
''',
          },
          outputs: {
            'a|lib/status.faker.g.part': decodedContainsAll([
              'f.nextNullable',
              'f.nextEnum(Priority.values)',
            ]),
          },
          rootPackage: 'a',
        );
      });
    });

    group('positional parameters', () {
      test('generates fake for class with positional parameters', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/point.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Point {
  final double x;
  final double y;
  Point(this.x, this.y);
}
''',
          },
          outputs: {
            'a|lib/point.faker.g.part': decodedContainsAll([
              'double x',
              'double y',
              'f.nextDouble()',
              'Point(',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test(
        'generates fake for class with mixed positional and named parameters',
        () async {
          await testBuilder(
            fakerBuilder(BuilderOptions.empty),
            {
              'a|lib/faker_annotation.dart': _fakeItSource,
              'a|lib/rect.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Rect {
  final double x;
  final double y;
  final double width;
  final double height;
  Rect(this.x, this.y, {required this.width, required this.height});
}
''',
            },
            outputs: {
              'a|lib/rect.faker.g.part': decodedContainsAll([
                'double x',
                'double y',
                'double width',
                'double height',
                'Rect(',
              ]),
            },
            rootPackage: 'a',
          );
        },
      );
    });

    group('nullable collection elements', () {
      test('generates fake for List<String?> with nullable elements', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/nullable_list.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class NullableList {
  final List<String?> items;
  NullableList({required this.items});
}
''',
          },
          outputs: {
            'a|lib/nullable_list.faker.g.part': decodedContainsAll([
              'f.nextListOf',
              'f.nextNullable',
              'f.nextString()',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('generates fake for Map with nullable value type', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/nullable_map.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class NullableMap {
  final Map<String, int?> scores;
  NullableMap({required this.scores});
}
''',
          },
          outputs: {
            'a|lib/nullable_map.faker.g.part': decodedContainsAll([
              'Map.fromEntries',
              'f.nextString()',
              'f.nextNullable',
              'f.nextInt()',
            ]),
          },
          rootPackage: 'a',
        );
      });
    });

    group('@FakeWith annotation', () {
      test('generates fake using custom fake function', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/custom.dart': r'''
import 'faker_annotation.dart';

String customNameGenerator(Faker f) => 'CustomName';

@FakeIt()
class CustomUser {
  @FakeWith(customNameGenerator)
  final String name;
  CustomUser({required this.name});
}
''',
          },
          outputs: {
            'a|lib/custom.faker.g.part': decodedContains(
              'customNameGenerator(f)',
            ),
          },
          rootPackage: 'a',
        );
      });
    });

    group('generated code structure', () {
      test('generates code with shared sentinel', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/item.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Item {
  final String id;
  Item({required this.id});
}
''',
          },
          outputs: {
            'a|lib/item.faker.g.part': decodedContainsAll([
              r'$undefined',
              r'identical(id, $undefined)',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('generates interface with proper documentation', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/item.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Item {
  final String id;
  Item({required this.id});
}
''',
          },
          outputs: {
            'a|lib/item.faker.g.part': decodedContainsAll([
              '/// Creates a fake instance of [Item]',
              r'abstract mixin class _$FakeItem',
              'Item call({',
              'Faker? faker',
              'String id',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('generates implementation with shared sentinel defaults', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/item.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Item {
  final String id;
  Item({required this.id});
}
''',
          },
          outputs: {
            'a|lib/item.faker.g.part': decodedContainsAll([
              r'class _$FakeItemImpl with _$FakeItem',
              r'const _$FakeItemImpl();',
              '@override',
              r'Object id = $undefined',
              r'identical(id, $undefined)',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('generates top-level const factory', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/item.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Item {
  final String id;
  Item({required this.id});
}
''',
          },
          outputs: {
            'a|lib/item.faker.g.part': decodedContainsAll([
              '/// Fake factory for [Item]',
              r'const fakeItem = _$FakeItemImpl();',
            ]),
          },
          rootPackage: 'a',
        );
      });
    });
  });
}
