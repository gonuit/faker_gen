import 'package:faker_gen/src/generation/fake_factory_generator.dart';
import 'package:faker_gen/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('FakeAs Generator', () {
    late FakeFactoryGenerator generator;
    const config = FakerConfig(
      seed: null,
      generateNullForNullable: false,
      nullProbability: 0.3,
    );

    setUp(() {
      generator = FakeFactoryGenerator();
    });

    // ─── String ──────────────────────────────────────────────────────────────

    group('FakeAs.string', () {
      test('generates f.nextString() without args', () {
        final fields = [
          FieldInfo(
            name: 'value',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextString',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextString()'));
      });

      test('generates f.nextString() with prefix arg', () {
        final fields = [
          FieldInfo(
            name: 'value',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextString',
            fakeAsArgs: "prefix: 'test_'",
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains("f.nextString(prefix: 'test_')"));
      });
    });

    group('FakeAs.uuid', () {
      test('generates f.nextUuid()', () {
        final fields = [
          FieldInfo(
            name: 'id',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextUuid',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextUuid()'));
      });
    });

    // ─── DateTime ────────────────────────────────────────────────────────────

    group('FakeAs.dateTime', () {
      test('generates f.nextDateTime() with default args', () {
        final fields = [
          FieldInfo(
            name: 'createdAt',
            typeDisplayString: 'DateTime',
            typeInfo: TypeInfo.dateTime(displayString: 'DateTime'),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextDateTime',
            fakeAsArgs: 'minYear: 2000, maxYear: 2030',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(
          result,
          contains('f.nextDateTime(minYear: 2000, maxYear: 2030)'),
        );
      });

      test('generates f.nextDateTime() with custom args', () {
        final fields = [
          FieldInfo(
            name: 'birthDate',
            typeDisplayString: 'DateTime',
            typeInfo: TypeInfo.dateTime(displayString: 'DateTime'),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextDateTime',
            fakeAsArgs: 'minYear: 1950, maxYear: 2000',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(
          result,
          contains('f.nextDateTime(minYear: 1950, maxYear: 2000)'),
        );
      });
    });

    group('FakeAs.month', () {
      test('generates f.nextMonth()', () {
        final fields = [
          FieldInfo(
            name: 'month',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextMonth',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextMonth()'));
      });
    });

    group('FakeAs.year', () {
      test('generates f.nextYear()', () {
        final fields = [
          FieldInfo(
            name: 'year',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextYear',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextYear()'));
      });
    });

    group('FakeAs.time', () {
      test('generates f.nextTime()', () {
        final fields = [
          FieldInfo(
            name: 'time',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextTime',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextTime()'));
      });
    });

    // ─── Person ──────────────────────────────────────────────────────────────

    group('FakeAs.firstName', () {
      test('generates f.nextFirstName()', () {
        final fields = [
          FieldInfo(
            name: 'firstName',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextFirstName',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextFirstName()'));
      });
    });

    group('FakeAs.lastName', () {
      test('generates f.nextLastName()', () {
        final fields = [
          FieldInfo(
            name: 'lastName',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextLastName',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextLastName()'));
      });
    });

    group('FakeAs.fullName', () {
      test('generates f.nextFullName()', () {
        final fields = [
          FieldInfo(
            name: 'fullName',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextFullName',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextFullName()'));
      });
    });

    group('FakeAs.personPrefix', () {
      test('generates f.nextPersonPrefix()', () {
        final fields = [
          FieldInfo(
            name: 'prefix',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextPersonPrefix',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextPersonPrefix()'));
      });
    });

    group('FakeAs.personSuffix', () {
      test('generates f.nextPersonSuffix()', () {
        final fields = [
          FieldInfo(
            name: 'suffix',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextPersonSuffix',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextPersonSuffix()'));
      });
    });

    // ─── Job ─────────────────────────────────────────────────────────────────

    group('FakeAs.jobTitle', () {
      test('generates f.nextJobTitle()', () {
        final fields = [
          FieldInfo(
            name: 'jobTitle',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextJobTitle',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextJobTitle()'));
      });
    });

    // ─── Internet ────────────────────────────────────────────────────────────

    group('FakeAs.email', () {
      test('generates f.nextEmail()', () {
        final fields = [
          FieldInfo(
            name: 'email',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextEmail',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextEmail()'));
      });
    });

    group('FakeAs.freeEmail', () {
      test('generates f.nextFreeEmail()', () {
        final fields = [
          FieldInfo(
            name: 'email',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextFreeEmail',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextFreeEmail()'));
      });
    });

    group('FakeAs.safeEmail', () {
      test('generates f.nextSafeEmail()', () {
        final fields = [
          FieldInfo(
            name: 'email',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextSafeEmail',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextSafeEmail()'));
      });
    });

    group('FakeAs.disposableEmail', () {
      test('generates f.nextDisposableEmail()', () {
        final fields = [
          FieldInfo(
            name: 'email',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextDisposableEmail',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextDisposableEmail()'));
      });
    });

    group('FakeAs.username', () {
      test('generates f.nextUsername()', () {
        final fields = [
          FieldInfo(
            name: 'username',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextUsername',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextUsername()'));
      });
    });

    group('FakeAs.domainName', () {
      test('generates f.nextDomainName()', () {
        final fields = [
          FieldInfo(
            name: 'domain',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextDomainName',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextDomainName()'));
      });
    });

    group('FakeAs.domainWord', () {
      test('generates f.nextDomainWord()', () {
        final fields = [
          FieldInfo(
            name: 'domainWord',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextDomainWord',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextDomainWord()'));
      });
    });

    group('FakeAs.url', () {
      test('generates f.nextUrl()', () {
        final fields = [
          FieldInfo(
            name: 'url',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextUrl',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextUrl()'));
      });
    });

    group('FakeAs.httpUrl', () {
      test('generates f.nextHttpUrl()', () {
        final fields = [
          FieldInfo(
            name: 'url',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextHttpUrl',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextHttpUrl()'));
      });
    });

    group('FakeAs.httpsUrl', () {
      test('generates f.nextHttpsUrl()', () {
        final fields = [
          FieldInfo(
            name: 'url',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextHttpsUrl',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextHttpsUrl()'));
      });
    });

    group('FakeAs.ipv4Address', () {
      test('generates f.nextIpv4Address()', () {
        final fields = [
          FieldInfo(
            name: 'ip',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextIpv4Address',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextIpv4Address()'));
      });
    });

    group('FakeAs.ipv6Address', () {
      test('generates f.nextIpv6Address()', () {
        final fields = [
          FieldInfo(
            name: 'ip',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextIpv6Address',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextIpv6Address()'));
      });
    });

    group('FakeAs.macAddress', () {
      test('generates f.nextMacAddress()', () {
        final fields = [
          FieldInfo(
            name: 'mac',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextMacAddress',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextMacAddress()'));
      });
    });

    group('FakeAs.password', () {
      test('generates f.nextPassword() with default length', () {
        final fields = [
          FieldInfo(
            name: 'password',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextPassword',
            fakeAsArgs: 'length: 10',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextPassword(length: 10)'));
      });

      test('generates f.nextPassword() with custom length', () {
        final fields = [
          FieldInfo(
            name: 'password',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextPassword',
            fakeAsArgs: 'length: 32',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextPassword(length: 32)'));
      });
    });

    group('FakeAs.userAgent', () {
      test('generates f.nextUserAgent()', () {
        final fields = [
          FieldInfo(
            name: 'userAgent',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextUserAgent',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextUserAgent()'));
      });
    });

    // ─── Address ─────────────────────────────────────────────────────────────

    group('FakeAs.zipCode', () {
      test('generates f.nextZipCode()', () {
        final fields = [
          FieldInfo(
            name: 'zipCode',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextZipCode',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextZipCode()'));
      });
    });

    group('FakeAs.city', () {
      test('generates f.nextCity()', () {
        final fields = [
          FieldInfo(
            name: 'city',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCity',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCity()'));
      });
    });

    group('FakeAs.cityPrefix', () {
      test('generates f.nextCityPrefix()', () {
        final fields = [
          FieldInfo(
            name: 'cityPrefix',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCityPrefix',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCityPrefix()'));
      });
    });

    group('FakeAs.citySuffix', () {
      test('generates f.nextCitySuffix()', () {
        final fields = [
          FieldInfo(
            name: 'citySuffix',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCitySuffix',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCitySuffix()'));
      });
    });

    group('FakeAs.streetName', () {
      test('generates f.nextStreetName()', () {
        final fields = [
          FieldInfo(
            name: 'streetName',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextStreetName',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextStreetName()'));
      });
    });

    group('FakeAs.streetAddress', () {
      test('generates f.nextStreetAddress()', () {
        final fields = [
          FieldInfo(
            name: 'streetAddress',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextStreetAddress',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextStreetAddress()'));
      });
    });

    group('FakeAs.streetSuffix', () {
      test('generates f.nextStreetSuffix()', () {
        final fields = [
          FieldInfo(
            name: 'streetSuffix',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextStreetSuffix',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextStreetSuffix()'));
      });
    });

    group('FakeAs.buildingNumber', () {
      test('generates f.nextBuildingNumber()', () {
        final fields = [
          FieldInfo(
            name: 'buildingNumber',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextBuildingNumber',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextBuildingNumber()'));
      });
    });

    group('FakeAs.neighborhood', () {
      test('generates f.nextNeighborhood()', () {
        final fields = [
          FieldInfo(
            name: 'neighborhood',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextNeighborhood',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextNeighborhood()'));
      });
    });

    group('FakeAs.state', () {
      test('generates f.nextState()', () {
        final fields = [
          FieldInfo(
            name: 'state',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextState',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextState()'));
      });
    });

    group('FakeAs.stateAbbreviation', () {
      test('generates f.nextStateAbbreviation()', () {
        final fields = [
          FieldInfo(
            name: 'stateAbbr',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextStateAbbreviation',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextStateAbbreviation()'));
      });
    });

    group('FakeAs.country', () {
      test('generates f.nextCountry()', () {
        final fields = [
          FieldInfo(
            name: 'country',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCountry',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCountry()'));
      });
    });

    group('FakeAs.countryCode', () {
      test('generates f.nextCountryCode()', () {
        final fields = [
          FieldInfo(
            name: 'countryCode',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCountryCode',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCountryCode()'));
      });
    });

    group('FakeAs.continent', () {
      test('generates f.nextContinent()', () {
        final fields = [
          FieldInfo(
            name: 'continent',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextContinent',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextContinent()'));
      });
    });

    // ─── Company ─────────────────────────────────────────────────────────────

    group('FakeAs.companyName', () {
      test('generates f.nextCompanyName()', () {
        final fields = [
          FieldInfo(
            name: 'companyName',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCompanyName',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCompanyName()'));
      });
    });

    group('FakeAs.companyPosition', () {
      test('generates f.nextCompanyPosition()', () {
        final fields = [
          FieldInfo(
            name: 'position',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCompanyPosition',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCompanyPosition()'));
      });
    });

    group('FakeAs.companySuffix', () {
      test('generates f.nextCompanySuffix()', () {
        final fields = [
          FieldInfo(
            name: 'companySuffix',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCompanySuffix',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCompanySuffix()'));
      });
    });

    // ─── Lorem ───────────────────────────────────────────────────────────────

    group('FakeAs.word', () {
      test('generates f.nextWord()', () {
        final fields = [
          FieldInfo(
            name: 'word',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextWord',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextWord()'));
      });
    });

    group('FakeAs.words', () {
      test('generates f.nextWords() with default count', () {
        final fields = [
          FieldInfo(
            name: 'words',
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
            fakeAsMethod: 'nextWords',
            fakeAsArgs: 'count: 3',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextWords(count: 3)'));
      });

      test('generates f.nextWords() with custom count', () {
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
            fakeAsMethod: 'nextWords',
            fakeAsArgs: 'count: 10',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextWords(count: 10)'));
      });
    });

    group('FakeAs.sentence', () {
      test('generates f.nextSentence()', () {
        final fields = [
          FieldInfo(
            name: 'sentence',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextSentence',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextSentence()'));
      });
    });

    group('FakeAs.sentences', () {
      test('generates f.nextSentences() with default count', () {
        final fields = [
          FieldInfo(
            name: 'sentences',
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
            fakeAsMethod: 'nextSentences',
            fakeAsArgs: 'count: 3',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextSentences(count: 3)'));
      });

      test('generates f.nextSentences() with custom count', () {
        final fields = [
          FieldInfo(
            name: 'lines',
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
            fakeAsMethod: 'nextSentences',
            fakeAsArgs: 'count: 5',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextSentences(count: 5)'));
      });
    });

    group('FakeAs.paragraph', () {
      test('generates f.nextParagraph()', () {
        final fields = [
          FieldInfo(
            name: 'paragraph',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextParagraph',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextParagraph()'));
      });
    });

    // ─── Phone ───────────────────────────────────────────────────────────────

    group('FakeAs.phoneNumber', () {
      test('generates f.nextPhoneNumber()', () {
        final fields = [
          FieldInfo(
            name: 'phone',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextPhoneNumber',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextPhoneNumber()'));
      });
    });

    // ─── Currency ────────────────────────────────────────────────────────────

    group('FakeAs.currencyCode', () {
      test('generates f.nextCurrencyCode()', () {
        final fields = [
          FieldInfo(
            name: 'currencyCode',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCurrencyCode',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCurrencyCode()'));
      });
    });

    group('FakeAs.currencyName', () {
      test('generates f.nextCurrencyName()', () {
        final fields = [
          FieldInfo(
            name: 'currencyName',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCurrencyName',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCurrencyName()'));
      });
    });

    // ─── Color ───────────────────────────────────────────────────────────────

    group('FakeAs.color', () {
      test('generates f.nextColor()', () {
        final fields = [
          FieldInfo(
            name: 'color',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextColor',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextColor()'));
      });
    });

    group('FakeAs.commonColor', () {
      test('generates f.nextCommonColor()', () {
        final fields = [
          FieldInfo(
            name: 'color',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCommonColor',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCommonColor()'));
      });
    });

    group('FakeAs.rgbColor', () {
      test('generates f.nextRgbColor()', () {
        final fields = [
          FieldInfo(
            name: 'rgb',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextRgbColor',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextRgbColor()'));
      });
    });

    // ─── Food ────────────────────────────────────────────────────────────────

    group('FakeAs.restaurant', () {
      test('generates f.nextRestaurant()', () {
        final fields = [
          FieldInfo(
            name: 'restaurant',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextRestaurant',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextRestaurant()'));
      });
    });

    group('FakeAs.dish', () {
      test('generates f.nextDish()', () {
        final fields = [
          FieldInfo(
            name: 'dish',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextDish',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextDish()'));
      });
    });

    group('FakeAs.cuisine', () {
      test('generates f.nextCuisine()', () {
        final fields = [
          FieldInfo(
            name: 'cuisine',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextCuisine',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextCuisine()'));
      });
    });

    // ─── Sport ───────────────────────────────────────────────────────────────

    group('FakeAs.sport', () {
      test('generates f.nextSport()', () {
        final fields = [
          FieldInfo(
            name: 'sport',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextSport',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextSport()'));
      });
    });

    // ─── Animal ──────────────────────────────────────────────────────────────

    group('FakeAs.animal', () {
      test('generates f.nextAnimal()', () {
        final fields = [
          FieldInfo(
            name: 'animal',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextAnimal',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextAnimal()'));
      });
    });

    // ─── Vehicle ─────────────────────────────────────────────────────────────

    group('FakeAs.vehicleMake', () {
      test('generates f.nextVehicleMake()', () {
        final fields = [
          FieldInfo(
            name: 'make',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextVehicleMake',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextVehicleMake()'));
      });
    });

    group('FakeAs.vehicleModel', () {
      test('generates f.nextVehicleModel()', () {
        final fields = [
          FieldInfo(
            name: 'model',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextVehicleModel',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextVehicleModel()'));
      });
    });

    group('FakeAs.vehicleYear', () {
      test('generates f.nextVehicleYear()', () {
        final fields = [
          FieldInfo(
            name: 'year',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextVehicleYear',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextVehicleYear()'));
      });
    });

    group('FakeAs.vehicleYearMakeModel', () {
      test('generates f.nextVehicleYearMakeModel()', () {
        final fields = [
          FieldInfo(
            name: 'vehicle',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextVehicleYearMakeModel',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextVehicleYearMakeModel()'));
      });
    });

    group('FakeAs.vehicleVin', () {
      test('generates f.nextVehicleVin()', () {
        final fields = [
          FieldInfo(
            name: 'vin',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextVehicleVin',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextVehicleVin()'));
      });
    });

    // ─── Conference ──────────────────────────────────────────────────────────

    group('FakeAs.conference', () {
      test('generates f.nextConference()', () {
        final fields = [
          FieldInfo(
            name: 'conference',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextConference',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextConference()'));
      });
    });

    // ─── Geo ─────────────────────────────────────────────────────────────────

    group('FakeAs.latitude', () {
      test('generates f.nextLatitude()', () {
        final fields = [
          FieldInfo(
            name: 'lat',
            typeDisplayString: 'double',
            typeInfo: TypeInfo.primitive(
              displayString: 'double',
              primitiveType: 'double',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextLatitude',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextLatitude()'));
      });
    });

    group('FakeAs.longitude', () {
      test('generates f.nextLongitude()', () {
        final fields = [
          FieldInfo(
            name: 'lng',
            typeDisplayString: 'double',
            typeInfo: TypeInfo.primitive(
              displayString: 'double',
              primitiveType: 'double',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextLongitude',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextLongitude()'));
      });
    });

    // ─── JWT ─────────────────────────────────────────────────────────────────

    group('FakeAs.jwtValid', () {
      test('generates f.nextJwtValid()', () {
        final fields = [
          FieldInfo(
            name: 'token',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextJwtValid',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextJwtValid()'));
      });
    });

    group('FakeAs.jwtExpired', () {
      test('generates f.nextJwtExpired()', () {
        final fields = [
          FieldInfo(
            name: 'expiredToken',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextJwtExpired',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextJwtExpired()'));
      });
    });

    // ─── Image ───────────────────────────────────────────────────────────────

    group('FakeAs.imageUrl', () {
      test('generates f.nextImageUrl() with default args', () {
        final fields = [
          FieldInfo(
            name: 'imageUrl',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextImageUrl',
            fakeAsArgs: 'width: 640, height: 480',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextImageUrl(width: 640, height: 480)'));
      });

      test('generates f.nextImageUrl() with custom args', () {
        final fields = [
          FieldInfo(
            name: 'thumbnail',
            typeDisplayString: 'String',
            typeInfo: TypeInfo.primitive(
              displayString: 'String',
              primitiveType: 'String',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextImageUrl',
            fakeAsArgs: 'width: 100, height: 100',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextImageUrl(width: 100, height: 100)'));
      });
    });

    // ─── Primitives ──────────────────────────────────────────────────────────

    group('FakeAs.integer', () {
      test('generates f.nextInt() without args', () {
        final fields = [
          FieldInfo(
            name: 'count',
            typeDisplayString: 'int',
            typeInfo: TypeInfo.primitive(
              displayString: 'int',
              primitiveType: 'int',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextInt',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextInt()'));
      });

      test('generates f.nextInt() with min only', () {
        final fields = [
          FieldInfo(
            name: 'positiveCount',
            typeDisplayString: 'int',
            typeInfo: TypeInfo.primitive(
              displayString: 'int',
              primitiveType: 'int',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextInt',
            fakeAsArgs: 'min: 1',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextInt(min: 1)'));
      });

      test('generates f.nextInt() with max only', () {
        final fields = [
          FieldInfo(
            name: 'smallCount',
            typeDisplayString: 'int',
            typeInfo: TypeInfo.primitive(
              displayString: 'int',
              primitiveType: 'int',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextInt',
            fakeAsArgs: 'max: 100',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextInt(max: 100)'));
      });

      test('generates f.nextInt() with min and max', () {
        final fields = [
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
            fakeAsMethod: 'nextInt',
            fakeAsArgs: 'min: 18, max: 65',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextInt(min: 18, max: 65)'));
      });
    });

    group('FakeAs.decimal', () {
      test('generates f.nextDouble() without args', () {
        final fields = [
          FieldInfo(
            name: 'ratio',
            typeDisplayString: 'double',
            typeInfo: TypeInfo.primitive(
              displayString: 'double',
              primitiveType: 'double',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextDouble',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextDouble()'));
      });

      test('generates f.nextDouble() with min only', () {
        final fields = [
          FieldInfo(
            name: 'positiveRatio',
            typeDisplayString: 'double',
            typeInfo: TypeInfo.primitive(
              displayString: 'double',
              primitiveType: 'double',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextDouble',
            fakeAsArgs: 'min: 0.0',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextDouble(min: 0.0)'));
      });

      test('generates f.nextDouble() with max only', () {
        final fields = [
          FieldInfo(
            name: 'percentage',
            typeDisplayString: 'double',
            typeInfo: TypeInfo.primitive(
              displayString: 'double',
              primitiveType: 'double',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextDouble',
            fakeAsArgs: 'max: 100.0',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextDouble(max: 100.0)'));
      });

      test('generates f.nextDouble() with min and max', () {
        final fields = [
          FieldInfo(
            name: 'price',
            typeDisplayString: 'double',
            typeInfo: TypeInfo.primitive(
              displayString: 'double',
              primitiveType: 'double',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextDouble',
            fakeAsArgs: 'min: 0.99, max: 999.99',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextDouble(min: 0.99, max: 999.99)'));
      });
    });

    // ─── Nullable Fields ─────────────────────────────────────────────────────

    group('Nullable fields with FakeAs', () {
      test('generates nullable field with FakeAs.email', () {
        final fields = [
          FieldInfo(
            name: 'email',
            typeDisplayString: 'String?',
            typeInfo: TypeInfo.primitive(
              displayString: 'String?',
              primitiveType: 'String',
            ),
            isNullable: true,
            isRequired: false,
            isNamed: true,
            fakeAsMethod: 'nextEmail',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: const FakerConfig(
            generateNullForNullable: true,
            nullProbability: 0.3,
          ),
        );

        expect(result, contains('f.nextEmail()'));
        expect(result, contains('f.nextNullable'));
      });
    });

    // ─── Type Compatibility ──────────────────────────────────────────────────

    group('Type compatibility', () {
      test('FakeAs.latitude on num field', () {
        final fields = [
          FieldInfo(
            name: 'lat',
            typeDisplayString: 'num',
            typeInfo: TypeInfo.primitive(
              displayString: 'num',
              primitiveType: 'num',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextLatitude',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextLatitude()'));
      });

      test('FakeAs.integer on num field', () {
        final fields = [
          FieldInfo(
            name: 'count',
            typeDisplayString: 'num',
            typeInfo: TypeInfo.primitive(
              displayString: 'num',
              primitiveType: 'num',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextInt',
            fakeAsArgs: 'min: 0, max: 100',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextInt(min: 0, max: 100)'));
      });
    });

    // ─── Dynamic Type Support ────────────────────────────────────────────────

    group('FakeAs on dynamic fields', () {
      test('FakeAs.string on dynamic field generates correct code', () {
        final fields = [
          FieldInfo(
            name: 'data',
            typeDisplayString: 'dynamic',
            typeInfo: TypeInfo.fakeWithFunction(
              displayString: 'dynamic',
              functionName: '', // Not used when fakeAsMethod is set
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextString',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextString()'));
        expect(result, contains('data as dynamic'));
      });

      test('FakeAs.integer on dynamic field', () {
        final fields = [
          FieldInfo(
            name: 'value',
            typeDisplayString: 'dynamic',
            typeInfo: TypeInfo.fakeWithFunction(
              displayString: 'dynamic',
              functionName: '',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextInt',
            fakeAsArgs: 'min: 1, max: 10',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextInt(min: 1, max: 10)'));
      });

      test('FakeAs.email on Object field', () {
        final fields = [
          FieldInfo(
            name: 'contact',
            typeDisplayString: 'Object',
            typeInfo: TypeInfo.fakeWithFunction(
              displayString: 'Object',
              functionName: '',
            ),
            isNullable: false,
            isRequired: true,
            isNamed: true,
            fakeAsMethod: 'nextEmail',
          ),
        ];

        final result = generator.generate(
          className: 'Test',
          fields: fields,
          config: config,
        );

        expect(result, contains('f.nextEmail()'));
        expect(result, contains('contact as Object'));
      });
    });
  });
}
