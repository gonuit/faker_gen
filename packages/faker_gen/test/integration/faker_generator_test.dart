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

class FakeAs {
  final String method;
  final String returnType;
  final String? args;
  
  const FakeAs.uuid() : method = 'nextUuid', returnType = 'String', args = null;
}

class FakeValue {
  const FakeValue(this.value);
  final Object? value;
}

class Faker {
  Faker([int? seed]);
  String nextString() => '';
  String nextUuid() => '';
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

    group('@FakeValue annotation', () {
      test('generates fake with constant string value', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/config.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Config {
  @FakeValue('production')
  final String environment;
  Config({required this.environment});
}
''',
          },
          outputs: {
            'a|lib/config.faker.g.part': decodedContainsAll([
              "identical(environment, \$undefined)",
              "'production'",
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('generates fake with constant int value', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/settings.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Settings {
  @FakeValue(42)
  final int maxRetries;
  Settings({required this.maxRetries});
}
''',
          },
          outputs: {
            'a|lib/settings.faker.g.part': decodedContainsAll([
              'identical(maxRetries, \$undefined)',
              '? 42',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('generates fake with constant bool value', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/feature.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Feature {
  @FakeValue(true)
  final bool enabled;
  Feature({required this.enabled});
}
''',
          },
          outputs: {
            'a|lib/feature.faker.g.part': decodedContainsAll([
              'identical(enabled, \$undefined)',
              '? true',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('generates fake with null value', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/optional.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class Optional {
  @FakeValue(null)
  final String? maybeValue;
  Optional({this.maybeValue});
}
''',
          },
          outputs: {
            'a|lib/optional.faker.g.part': decodedContainsAll([
              'identical(maybeValue, \$undefined)',
              '? null',
              ': maybeValue as String?',
            ]),
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

      test('only generates for constructor parameters, not all class fields', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/user.dart': r'''
import 'faker_annotation.dart';

@FakeIt()
class User {
  final String name;
  final int age;
  final String? nickname; // Not in constructor - should be ignored

  User({required this.name, required this.age});
}
''',
          },
          outputs: {
            'a|lib/user.faker.g.part': allOf([
              decodedContainsAll([
                'String name',
                'int age',
                'name: identical(name, \$undefined) ? f.nextString() : name as String',
                'age: identical(age, \$undefined) ? f.nextInt() : age as int',
              ]),
              // Should NOT contain nickname since it's not in constructor
              isNot(decodedContains('nickname')),
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('supports annotations on super constructor parameters', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/models.dart': r'''
import 'faker_annotation.dart';

Map<String, dynamic> mockPayment(Faker f) => {'method': 'card'};

class BaseOrder {
  final String orderId;
  final Map<String, dynamic> payment;
  BaseOrder({required this.orderId, required this.payment});
}

@FakeIt()
class Order extends BaseOrder {
  final String name;

  Order({
    required this.name,
    @FakeAs.uuid()
    required String orderId,
    @FakeWith(mockPayment)
    required Map<String, dynamic> payment,
  }) : super(orderId: orderId, payment: payment);
}
''',
          },
          outputs: {
            'a|lib/models.faker.g.part': decodedContainsAll([
              // Should use @FakeAs.uuid() on the orderId parameter
              'f.nextUuid()',
              // Should use @FakeWith(mockPayment) on the payment parameter
              'mockPayment(f)',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('finds annotations on parent class fields', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/models.dart': r'''
import 'faker_annotation.dart';

Map<String, dynamic> mockPayment(Faker f) => {'method': 'card'};

class BaseOrder {
  @FakeAs.uuid()
  final String orderId;
  @FakeWith(mockPayment)
  final Map<String, dynamic> payment;
  BaseOrder({required this.orderId, required this.payment});
}

@FakeIt()
class Order extends BaseOrder {
  final String name;

  // No annotations needed on constructor params - found on parent class fields
  Order({
    required this.name,
    required super.orderId,
    required super.payment,
  });
}
''',
          },
          outputs: {
            'a|lib/models.faker.g.part': decodedContainsAll([
              // Should find @FakeAs.uuid() on BaseOrder.orderId
              'f.nextUuid()',
              // Should find @FakeWith(mockPayment) on BaseOrder.payment
              'mockPayment(f)',
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('supports Freezed-style factory constructors', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/app_file.dart': r'''
import 'faker_annotation.dart';

// Simulating Freezed-generated mixin
mixin _$AppFile {
  String? get fileName;
  String? get fileType;
}

@FakeIt()
abstract class AppFile with _$AppFile {
  const factory AppFile({
    String? fileName,
    String? fileType,
  }) = _AppFile;
}

// Simulating Freezed-generated implementation
class _AppFile with _$AppFile implements AppFile {
  const _AppFile({this.fileName, this.fileType});
  
  @override
  final String? fileName;
  @override
  final String? fileType;
}
''',
          },
          outputs: {
            'a|lib/app_file.faker.g.part': allOf([
              decodedContainsAll([
                'fakeAppFile',
                'fileName',
                'fileType',
              ]),
              // IMPORTANT: Should use public AppFile constructor, NOT _AppFile
              decodedContains('return AppFile('),
              // Should NOT use the private redirected class
              isNot(decodedContains('return _AppFile(')),
            ]),
          },
          rootPackage: 'a',
        );
      });

      test('supports annotations on Freezed-style factory constructor params', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'a|lib/faker_annotation.dart': _fakeItSource,
            'a|lib/app_file.dart': r'''
import 'faker_annotation.dart';

String fakeFileName(Faker f) => 'test.pdf';

// Simulating Freezed-generated mixin
mixin _$AppFile {
  String? get fileName;
  String? get fileId;
}

@FakeIt()
abstract class AppFile with _$AppFile {
  const factory AppFile({
    @FakeWith(fakeFileName) String? fileName,
    @FakeAs.uuid() String? fileId,
  }) = _AppFile;
}

// Simulating Freezed-generated implementation
class _AppFile with _$AppFile implements AppFile {
  const _AppFile({this.fileName, this.fileId});
  
  @override
  final String? fileName;
  @override
  final String? fileId;
}
''',
          },
          outputs: {
            'a|lib/app_file.faker.g.part': decodedContainsAll([
              // Should use @FakeWith on factory constructor param
              'fakeFileName(f)',
              // Should use @FakeAs.uuid() on factory constructor param
              'f.nextUuid()',
            ]),
          },
          rootPackage: 'a',
        );
      });
    });
  });
}
