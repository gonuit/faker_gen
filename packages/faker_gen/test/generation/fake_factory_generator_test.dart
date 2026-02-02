import 'package:faker_gen/src/generation/fake_factory_generator.dart';
import 'package:faker_gen/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('FakeFactoryGenerator', () {
    late FakeFactoryGenerator generator;

    setUp(() {
      generator = FakeFactoryGenerator();
    });

    group('generate', () {
      test('generates valid code for simple class with String field', () {
        final fields = [
          FieldInfo(
            name: 'name',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
          ),
        ];

        final result = generator.generate(
          className: 'User',
          fields: fields,
          config: const FakerConfig(
            generateNullForNullable: false,
            nullProbability: 0.3,
          ),
        );

        expect(result, contains(r'$undefined')); // shared sentinel
        expect(
          result,
          isNot(contains('class _\$UserSentinel')),
        ); // no per-class sentinel
        expect(result, contains('abstract class _\$FakeUser'));
        expect(result, contains('class _\$FakeUserImpl'));
        expect(result, contains('const _\$FakeUser fakeUser = _\$FakeUserImpl()'));
        expect(result, contains('f.nextString()'));
      });

      test('generates code with shared sentinel', () {
        final fields = [
          FieldInfo(
            name: 'value',
            typeDisplayString: 'int',
            typeInfo: TypeInfo.primitive(
              displayString: 'int',
              primitiveType: 'int',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
          ),
        ];

        final result = generator.generate(
          className: 'Counter',
          fields: fields,
          config: const FakerConfig(
            generateNullForNullable: false,
            nullProbability: 0.3,
          ),
        );

        expect(result, isNot(contains('class _\$CounterSentinel')));
        expect(result, isNot(contains('_\$counterSentinel')));
        expect(result, contains(r'$undefined'));
        expect(result, contains(r'identical(value, $undefined)'));
      });

      test('generates nullable handling when enabled', () {
        final fields = [
          FieldInfo(
            name: 'bio',
            typeDisplayString: 'String?',
            typeInfo: TypeInfo.primitive(
              displayString: 'String?',
              primitiveType: 'String',
            ),
            isNullable: true,
            isRequired: false,
            isNamed: true,
          ),
        ];

        final result = generator.generate(
          className: 'Profile',
          fields: fields,
          config: const FakerConfig(
            generateNullForNullable: true,
            nullProbability: 0.3,
          ),
        );

        expect(result, contains('f.nextNullable'));
        expect(result, contains('nullWeight: 0.3'));
      });

      test('generates List handling', () {
        final fields = [
          FieldInfo(
            name: 'tags',
            typeDisplayString: 'List<String>',
            typeInfo: TypeInfo.list(
              displayString: 'List<String>',
              elementType: TypeInfo.primitive(
                displayString: 'String',
                primitiveType: 'String',
              ),
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
          ),
        ];

        final result = generator.generate(
          className: 'Article',
          fields: fields,
          config: const FakerConfig(
            generateNullForNullable: false,
            nullProbability: 0.3,
          ),
        );

        expect(result, contains('f.nextListOf'));
        expect(result, contains('tags as List<String>'));
      });

      test('generates Map handling', () {
        final fields = [
          FieldInfo(
            name: 'scores',
            typeDisplayString: 'Map<String, int>',
            typeInfo: TypeInfo.map(
              displayString: 'Map<String, int>',
              keyType: TypeInfo.primitive(
                displayString: 'String',
                primitiveType: 'String',
              ),
              valueType: TypeInfo.primitive(
                displayString: 'int',
                primitiveType: 'int',
              ),
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
          ),
        ];

        final result = generator.generate(
          className: 'Leaderboard',
          fields: fields,
          config: const FakerConfig(
            generateNullForNullable: false,
            nullProbability: 0.3,
          ),
        );

        expect(result, contains('Map.fromEntries'));
        expect(result, contains('MapEntry'));
        expect(result, contains('scores as Map<String, int>'));
      });

      test('generates double field with num conversion', () {
        final fields = [
          FieldInfo(
            name: 'value',
            typeDisplayString: 'double',
            typeInfo: TypeInfo.primitive(
              displayString: 'double',
              primitiveType: 'double',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
          ),
        ];

        final result = generator.generate(
          className: 'Measurement',
          fields: fields,
          config: const FakerConfig(
            generateNullForNullable: false,
            nullProbability: 0.3,
          ),
        );

        expect(result, contains('f.nextDouble()'));
        expect(result, contains('(value as num).toDouble()'));
      });

      test('generates DateTime handling', () {
        final fields = [
          FieldInfo(
            name: 'timestamp',
            typeDisplayString: 'DateTime',
            typeInfo: TypeInfo.dateTime(displayString: 'DateTime'),
            isNullable: false,
            isRequired: true,
            isNamed: true,
          ),
        ];

        final result = generator.generate(
          className: 'Event',
          fields: fields,
          config: const FakerConfig(
            generateNullForNullable: false,
            nullProbability: 0.3,
          ),
        );

        expect(result, contains('f.nextDateTime()'));
      });

      test('generates faker class reference', () {
        final fields = [
          FieldInfo(
            name: 'author',
            typeDisplayString: 'User',
            typeInfo: TypeInfo.fakerClass(
              displayString: 'User',
              className: 'User',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
          ),
        ];

        final result = generator.generate(
          className: 'Post',
          fields: fields,
          config: const FakerConfig(
            generateNullForNullable: false,
            nullProbability: 0.3,
          ),
        );

        expect(result, contains('fakeUser(faker: f)'));
      });

      test('generates fakeWith function reference', () {
        final fields = [
          FieldInfo(
            name: 'metadata',
            typeDisplayString: 'Object',
            typeInfo: TypeInfo.fakeWithFunction(
              displayString: 'Object',
              functionName: 'fakeMetadata',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
          ),
        ];

        final result = generator.generate(
          className: 'Document',
          fields: fields,
          config: const FakerConfig(
            generateNullForNullable: false,
            nullProbability: 0.3,
          ),
        );

        expect(result, contains('fakeMetadata(f)'));
      });

      test('generates multiple fields correctly', () {
        final fields = [
          FieldInfo(
            name: 'name',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
          ),
          FieldInfo(
            name: 'age',
            typeDisplayString: 'int',
            typeInfo: TypeInfo.primitive(
              displayString: 'int',
              primitiveType: 'int',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
          ),
          FieldInfo(
            name: 'active',
            typeDisplayString: 'bool',
            typeInfo: TypeInfo.primitive(
              displayString: 'bool',
              primitiveType: 'bool',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
          ),
        ];

        final result = generator.generate(
          className: 'Person',
          fields: fields,
          config: const FakerConfig(
            generateNullForNullable: false,
            nullProbability: 0.3,
          ),
        );

        expect(result, contains('name:'));
        expect(result, contains('age:'));
        expect(result, contains('active:'));
        expect(result, contains('f.nextString()'));
        expect(result, contains('f.nextInt()'));
        expect(result, contains('f.nextBool()'));
      });

      test('generates ignore comment', () {
        final result = generator.generate(
          className: 'Empty',
          fields: [],
          config: const FakerConfig(
            generateNullForNullable: false,
            nullProbability: 0.3,
          ),
        );

        expect(result, contains('// ignore_for_file: unused_element'));
      });
    });
  });
}
