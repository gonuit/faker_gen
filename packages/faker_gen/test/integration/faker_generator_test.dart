import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:faker_gen/builder.dart';
import 'package:test/test.dart';

/// Creates a [TestReaderWriter] with all packages from the current isolate pre-loaded.
Future<TestReaderWriter> createTestReaderWriter() async {
  final readerWriter = TestReaderWriter(rootPackage: 'user_pkg');
  await readerWriter.testing.loadIsolateSources();
  return readerWriter;
}

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
            'user_pkg|lib/user.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class User {
  final String name;
  User({required this.name});
}
''',
          },
          outputs: {
            'user_pkg|lib/user.faker.g.part': decodedContainsAll([
              r'$undefined', // shared sentinel
              r'abstract class _$FakeUser',
              r'class _$FakeUserImpl',
              'const _\$FakeUser fakeUser = _\$FakeUserImpl()',
              'f.nextString()',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates fake for class with int field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/counter.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Counter {
  final int count;
  Counter({required this.count});
}
''',
          },
          outputs: {
            'user_pkg|lib/counter.faker.g.part': decodedContains('f.nextInt()'),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates fake for class with double field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/measurement.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Measurement {
  final double value;
  Measurement({required this.value});
}
''',
          },
          outputs: {
            'user_pkg|lib/measurement.faker.g.part': decodedContainsAll([
              'f.nextDouble()',
              '(value as num).toDouble()',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates fake for class with bool field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/flag.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Flag {
  final bool enabled;
  Flag({required this.enabled});
}
''',
          },
          outputs: {'user_pkg|lib/flag.faker.g.part': decodedContains('f.nextBool()')},
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates fake for class with multiple primitive fields', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/person.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

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
            'user_pkg|lib/person.faker.g.part': decodedContainsAll([
              'f.nextString()',
              'f.nextInt()',
              'f.nextBool()',
              'name:',
              'age:',
              'active:',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
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
              'user_pkg|lib/profile.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt(generateNullForNullable: true, nullProbability: 0.3)
class Profile {
  final String? bio;
  Profile({this.bio});
}
''',
            },
            outputs: {
              'user_pkg|lib/profile.faker.g.part': decodedContainsAll([
                'f.nextNullable',
                'nullWeight: 0.3',
              ]),
            },
            rootPackage: 'user_pkg',
            readerWriter: await createTestReaderWriter(),
          );
        },
      );

      test(
        'generates fake without nullable handling when generateNullForNullable is false',
        () async {
          await testBuilder(
            fakerBuilder(BuilderOptions.empty),
            {
              'user_pkg|lib/profile.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt(generateNullForNullable: false)
class Profile {
  final String? bio;
  Profile({this.bio});
}
''',
            },
            outputs: {
              'user_pkg|lib/profile.faker.g.part': decodedContains('f.nextString()'),
            },
            rootPackage: 'user_pkg',
            readerWriter: await createTestReaderWriter(),
          );
        },
      );
    });

    group('DateTime', () {
      test('generates fake for class with DateTime field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/event.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Event {
  final DateTime timestamp;
  Event({required this.timestamp});
}
''',
          },
          outputs: {
            'user_pkg|lib/event.faker.g.part': decodedContains('f.nextDateTime()'),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });
    });

    group('List types', () {
      test('generates fake for class with List<String> field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/tags.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Tags {
  final List<String> values;
  Tags({required this.values});
}
''',
          },
          outputs: {
            'user_pkg|lib/tags.faker.g.part': decodedContainsAll([
              'f.nextListOf',
              'f.nextString()',
              'values as List<String>',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });
    });

    group('Map types', () {
      test('generates fake for class with Map<String, int> field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/scores.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Scores {
  final Map<String, int> values;
  Scores({required this.values});
}
''',
          },
          outputs: {
            'user_pkg|lib/scores.faker.g.part': decodedContainsAll([
              'Map.fromEntries',
              'MapEntry',
              'f.nextString()',
              'f.nextInt()',
              'values as Map<String, int>',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });
    });

    group('Set types', () {
      test('generates fake for class with Set<String> field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/unique_tags.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class UniqueTags {
  final Set<String> tags;
  UniqueTags({required this.tags});
}
''',
          },
          outputs: {
            'user_pkg|lib/unique_tags.faker.g.part': decodedContainsAll([
              'f.nextListOf',
              'f.nextString()',
              '.toSet()',
              'tags as Set<String>',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates fake for class with Set<int> field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/unique_ids.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class UniqueIds {
  final Set<int> ids;
  UniqueIds({required this.ids});
}
''',
          },
          outputs: {
            'user_pkg|lib/unique_ids.faker.g.part': decodedContainsAll([
              'f.nextListOf',
              'f.nextInt()',
              '.toSet()',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });
    });

    group('enum types', () {
      test('generates fake for class with enum field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/status.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

enum Status { active, inactive, pending }

@FakeIt()
class Task {
  final Status status;
  Task({required this.status});
}
''',
          },
          outputs: {
            'user_pkg|lib/status.faker.g.part': decodedContainsAll([
              'f.nextEnum(Status.values)',
              'status as Status',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates fake for class with nullable enum field', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/status.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

enum Priority { low, medium, high }

@FakeIt()
class Task {
  final Priority? priority;
  Task({this.priority});
}
''',
          },
          outputs: {
            'user_pkg|lib/status.faker.g.part': decodedContainsAll([
              'f.nextNullable',
              'f.nextEnum(Priority.values)',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });
    });

    group('positional parameters', () {
      test('generates fake for class with positional parameters', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/point.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Point {
  final double x;
  final double y;
  Point(this.x, this.y);
}
''',
          },
          outputs: {
            'user_pkg|lib/point.faker.g.part': decodedContainsAll([
              'double x',
              'double y',
              'f.nextDouble()',
              'Point(',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test(
        'generates fake for class with mixed positional and named parameters',
        () async {
          await testBuilder(
            fakerBuilder(BuilderOptions.empty),
            {
              'user_pkg|lib/rect.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

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
              'user_pkg|lib/rect.faker.g.part': decodedContainsAll([
                'double x',
                'double y',
                'double width',
                'double height',
                'Rect(',
              ]),
            },
            rootPackage: 'user_pkg',
            readerWriter: await createTestReaderWriter(),
          );
        },
      );
    });

    group('nullable collection elements', () {
      test('generates fake for List<String?> with nullable elements', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/nullable_list.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class NullableList {
  final List<String?> items;
  NullableList({required this.items});
}
''',
          },
          outputs: {
            'user_pkg|lib/nullable_list.faker.g.part': decodedContainsAll([
              'f.nextListOf',
              'f.nextNullable',
              'f.nextString()',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates fake for Map with nullable value type', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/nullable_map.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class NullableMap {
  final Map<String, int?> scores;
  NullableMap({required this.scores});
}
''',
          },
          outputs: {
            'user_pkg|lib/nullable_map.faker.g.part': decodedContainsAll([
              'Map.fromEntries',
              'f.nextString()',
              'f.nextNullable',
              'f.nextInt()',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });
    });

    group('@FakeWith annotation', () {
      test('generates fake using custom fake function', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/custom.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

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
            'user_pkg|lib/custom.faker.g.part': decodedContains(
              'customNameGenerator(f)',
            ),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });
    });

    group('@FakeValue annotation', () {
      test('generates fake with constant string value', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/config.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Config {
  @FakeValue('production')
  final String environment;
  Config({required this.environment});
}
''',
          },
          outputs: {
            'user_pkg|lib/config.faker.g.part': decodedContainsAll([
              "identical(environment, \$undefined)",
              "'production'",
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates fake with constant int value', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/settings.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Settings {
  @FakeValue(42)
  final int maxRetries;
  Settings({required this.maxRetries});
}
''',
          },
          outputs: {
            'user_pkg|lib/settings.faker.g.part': decodedContainsAll([
              'identical(maxRetries, \$undefined)',
              '? 42',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates fake with constant bool value', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/feature.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Feature {
  @FakeValue(true)
  final bool enabled;
  Feature({required this.enabled});
}
''',
          },
          outputs: {
            'user_pkg|lib/feature.faker.g.part': decodedContainsAll([
              'identical(enabled, \$undefined)',
              '? true',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates fake with null value', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/optional.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Optional {
  @FakeValue(null)
  final String? maybeValue;
  Optional({this.maybeValue});
}
''',
          },
          outputs: {
            'user_pkg|lib/optional.faker.g.part': decodedContainsAll([
              'identical(maybeValue, \$undefined)',
              '? null',
              ': maybeValue as String?',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });
    });

    group('generated code structure', () {
      test('generates code with shared sentinel', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/item.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Item {
  final String id;
  Item({required this.id});
}
''',
          },
          outputs: {
            'user_pkg|lib/item.faker.g.part': decodedContainsAll([
              r'$undefined',
              r'identical(id, $undefined)',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates interface with proper documentation', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/item.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Item {
  final String id;
  Item({required this.id});
}
''',
          },
          outputs: {
            'user_pkg|lib/item.faker.g.part': decodedContainsAll([
              '/// Creates a fake instance of [Item]',
              r'abstract class _$FakeItem',
              'Item call({',
              'Faker? faker',
              'String id',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates implementation with shared sentinel defaults', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/item.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Item {
  final String id;
  Item({required this.id});
}
''',
          },
          outputs: {
            'user_pkg|lib/item.faker.g.part': decodedContainsAll([
              r'class _$FakeItemImpl implements _$FakeItem',
              r'const _$FakeItemImpl();',
              '@override',
              r'Object id = $undefined',
              r'identical(id, $undefined)',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('generates top-level const factory', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/item.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

@FakeIt()
class Item {
  final String id;
  Item({required this.id});
}
''',
          },
          outputs: {
            'user_pkg|lib/item.faker.g.part': decodedContainsAll([
              '/// Fake factory for [Item]',
              r'const _$FakeItem fakeItem = _$FakeItemImpl();',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test(
        'only generates for constructor parameters, not all class fields',
        () async {
          await testBuilder(
            fakerBuilder(BuilderOptions.empty),
            {
              'user_pkg|lib/user.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

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
              'user_pkg|lib/user.faker.g.part': allOf([
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
            rootPackage: 'user_pkg',
            readerWriter: await createTestReaderWriter(),
          );
        },
      );

      test('supports annotations on super constructor parameters', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/models.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

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
            'user_pkg|lib/models.faker.g.part': decodedContainsAll([
              // Should use @FakeAs.uuid() on the orderId parameter
              'f.nextUuid()',
              // Should use @FakeWith(mockPayment) on the payment parameter
              'mockPayment(f)',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('finds annotations on parent class fields', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/models.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

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
            'user_pkg|lib/models.faker.g.part': decodedContainsAll([
              // Should find @FakeAs.uuid() on BaseOrder.orderId
              'f.nextUuid()',
              // Should find @FakeWith(mockPayment) on BaseOrder.payment
              'mockPayment(f)',
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test('supports Freezed-style factory constructors', () async {
        await testBuilder(
          fakerBuilder(BuilderOptions.empty),
          {
            'user_pkg|lib/app_file.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

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
            'user_pkg|lib/app_file.faker.g.part': allOf([
              decodedContainsAll(['fakeAppFile', 'fileName', 'fileType']),
              // IMPORTANT: Should use public AppFile constructor, NOT _AppFile
              decodedContains('return AppFile('),
              // Should NOT use the private redirected class
              isNot(decodedContains('return _AppFile(')),
            ]),
          },
          rootPackage: 'user_pkg',
          readerWriter: await createTestReaderWriter(),
        );
      });

      test(
        'supports annotations on Freezed-style factory constructor params',
        () async {
          await testBuilder(
            fakerBuilder(BuilderOptions.empty),
            {
              'user_pkg|lib/app_file.dart': r'''
import 'package:faker_annotation/faker_annotation.dart';

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
              'user_pkg|lib/app_file.faker.g.part': decodedContainsAll([
                // Should use @FakeWith on factory constructor param
                'fakeFileName(f)',
                // Should use @FakeAs.uuid() on factory constructor param
                'f.nextUuid()',
              ]),
            },
            rootPackage: 'user_pkg',
            readerWriter: await createTestReaderWriter(),
          );
        },
      );
    });
  });
}
