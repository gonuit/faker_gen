import 'package:faker_annotation/faker_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('Faker', () {
    late Faker faker;

    setUp(() {
      // Use a fixed seed for reproducible tests
      faker = Faker(seed: 42);
    });

    group('Primitives', () {
      test('nextInt returns value within default range', () {
        for (var i = 0; i < 100; i++) {
          final value = faker.nextInt();
          expect(value, greaterThanOrEqualTo(0));
        }
      });

      test('nextInt returns value within specified range', () {
        for (var i = 0; i < 100; i++) {
          final value = faker.nextInt(min: 10, max: 20);
          expect(value, greaterThanOrEqualTo(10));
          expect(value, lessThan(20));
        }
      });

      test('nextDouble returns value within default range', () {
        for (var i = 0; i < 100; i++) {
          final value = faker.nextDouble();
          expect(value, greaterThanOrEqualTo(0.0));
          expect(value, lessThan(1.0));
        }
      });

      test('nextDouble returns value within specified range', () {
        for (var i = 0; i < 100; i++) {
          final value = faker.nextDouble(min: 5.0, max: 10.0);
          expect(value, greaterThanOrEqualTo(5.0));
          expect(value, lessThan(10.0));
        }
      });

      test('nextBool returns boolean', () {
        final value = faker.nextBool();
        expect(value, isA<bool>());
      });

      test('nextNum returns int or double', () {
        for (var i = 0; i < 100; i++) {
          final value = faker.nextNum(min: 0, max: 100);
          expect(value, isA<num>());
          expect(value, greaterThanOrEqualTo(0));
          expect(value, lessThanOrEqualTo(100));
        }
      });

      test('nextEnum returns valid enum value', () {
        final values = TestEnum.values;
        for (var i = 0; i < 100; i++) {
          final value = faker.nextEnum(values);
          expect(values, contains(value));
        }
      });

      test('nextFromList returns item from list', () {
        final items = ['a', 'b', 'c', 'd', 'e'];
        for (var i = 0; i < 100; i++) {
          final value = faker.nextFromList(items);
          expect(items, contains(value));
        }
      });

      test('nextListOf generates list with correct length range', () {
        for (var i = 0; i < 50; i++) {
          final list = faker.nextListOf(
            () => faker.nextInt(),
            minLength: 2,
            maxLength: 5,
          );
          expect(list.length, greaterThanOrEqualTo(2));
          expect(list.length, lessThan(5));
        }
      });

      test('nextNullable returns null or value based on weight', () {
        // With nullWeight 0.0, should never be null
        final alwaysValue = Faker(seed: 42);
        for (var i = 0; i < 100; i++) {
          final value = alwaysValue.nextNullable(() => 'test', nullWeight: 0.0);
          expect(value, isNotNull);
        }

        // With nullWeight 1.0, should always be null
        final alwaysNull = Faker(seed: 42);
        for (var i = 0; i < 100; i++) {
          final value = alwaysNull.nextNullable(() => 'test', nullWeight: 1.0);
          expect(value, isNull);
        }
      });
    });

    group('String', () {
      test('nextString returns non-empty string', () {
        final value = faker.nextString();
        expect(value, isNotEmpty);
      });

      test('nextString with prefix includes prefix', () {
        final value = faker.nextString(prefix: 'test_');
        expect(value, startsWith('test_'));
      });

      test('nextUuid returns valid UUID format', () {
        final value = faker.nextUuid();
        expect(
          value,
          matches(
            RegExp(
              r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
            ),
          ),
        );
      });
    });

    group('DateTime', () {
      test('nextDateTime returns DateTime within year range', () {
        final value = faker.nextDateTime(minYear: 2020, maxYear: 2025);
        expect(value.year, greaterThanOrEqualTo(2020));
        expect(value.year, lessThanOrEqualTo(2025));
      });

      test('nextDateTimeBetween returns DateTime within range', () {
        final start = DateTime(2020, 1, 1);
        final end = DateTime(2020, 12, 31);
        final value = faker.nextDateTimeBetween(start, end);
        expect(value.isAfter(start) || value.isAtSameMomentAs(start), isTrue);
        expect(value.isBefore(end) || value.isAtSameMomentAs(end), isTrue);
      });

      test('nextMonth returns non-empty string', () {
        final value = faker.nextMonth();
        expect(value, isNotEmpty);
      });

      test('nextYear returns year string within range', () {
        final value = faker.nextYear(minYear: 2020, maxYear: 2025);
        final year = int.parse(value);
        expect(year, greaterThanOrEqualTo(2020));
        expect(year, lessThanOrEqualTo(2025));
      });

      test('nextTime returns time string', () {
        final value = faker.nextTime();
        expect(value, isNotEmpty);
      });
    });

    group('Person', () {
      test('nextFirstName returns non-empty string', () {
        expect(faker.nextFirstName(), isNotEmpty);
      });

      test('nextLastName returns non-empty string', () {
        expect(faker.nextLastName(), isNotEmpty);
      });

      test('nextFullName returns non-empty string', () {
        expect(faker.nextFullName(), isNotEmpty);
      });

      test('nextPersonPrefix returns non-empty string', () {
        expect(faker.nextPersonPrefix(), isNotEmpty);
      });

      test('nextPersonSuffix returns non-empty string', () {
        expect(faker.nextPersonSuffix(), isNotEmpty);
      });
    });

    group('Job', () {
      test('nextJobTitle returns non-empty string', () {
        expect(faker.nextJobTitle(), isNotEmpty);
      });
    });

    group('Internet', () {
      test('nextEmail returns valid email format', () {
        final value = faker.nextEmail();
        expect(value, contains('@'));
        expect(value, contains('.'));
      });

      test('nextFreeEmail returns valid email', () {
        expect(faker.nextFreeEmail(), contains('@'));
      });

      test('nextSafeEmail returns valid email', () {
        expect(faker.nextSafeEmail(), contains('@'));
      });

      test('nextDisposableEmail returns valid email', () {
        expect(faker.nextDisposableEmail(), contains('@'));
      });

      test('nextUsername returns non-empty string', () {
        expect(faker.nextUsername(), isNotEmpty);
      });

      test('nextDomainName returns non-empty string', () {
        expect(faker.nextDomainName(), isNotEmpty);
      });

      test('nextDomainWord returns non-empty string', () {
        expect(faker.nextDomainWord(), isNotEmpty);
      });

      test('nextUrl returns HTTPS URL', () {
        expect(faker.nextUrl(), startsWith('https://'));
      });

      test('nextHttpUrl returns HTTP URL', () {
        expect(faker.nextHttpUrl(), startsWith('http://'));
      });

      test('nextHttpsUrl returns HTTPS URL', () {
        expect(faker.nextHttpsUrl(), startsWith('https://'));
      });

      test('nextUri returns URI with specified protocol', () {
        expect(faker.nextUri('ftp'), startsWith('ftp://'));
      });

      test('nextIpv4Address returns valid IPv4 format', () {
        final value = faker.nextIpv4Address();
        expect(value.split('.').length, equals(4));
      });

      test('nextIpv6Address returns non-empty string', () {
        expect(faker.nextIpv6Address(), isNotEmpty);
      });

      test('nextMacAddress returns valid MAC format', () {
        final value = faker.nextMacAddress();
        expect(value.split(':').length, equals(6));
      });

      test('nextPassword returns string of specified length', () {
        expect(faker.nextPassword(length: 15).length, equals(15));
      });

      test('nextUserAgent returns non-empty string', () {
        expect(faker.nextUserAgent(), isNotEmpty);
      });
    });

    group('Address', () {
      test('nextZipCode returns non-empty string', () {
        expect(faker.nextZipCode(), isNotEmpty);
      });

      test('nextCity returns non-empty string', () {
        expect(faker.nextCity(), isNotEmpty);
      });

      test('nextCityPrefix returns non-empty string', () {
        expect(faker.nextCityPrefix(), isNotEmpty);
      });

      test('nextCitySuffix returns non-empty string', () {
        expect(faker.nextCitySuffix(), isNotEmpty);
      });

      test('nextStreetName returns non-empty string', () {
        expect(faker.nextStreetName(), isNotEmpty);
      });

      test('nextStreetAddress returns non-empty string', () {
        expect(faker.nextStreetAddress(), isNotEmpty);
      });

      test('nextStreetSuffix returns non-empty string', () {
        expect(faker.nextStreetSuffix(), isNotEmpty);
      });

      test('nextBuildingNumber returns non-empty string', () {
        expect(faker.nextBuildingNumber(), isNotEmpty);
      });

      test('nextNeighborhood returns non-empty string', () {
        expect(faker.nextNeighborhood(), isNotEmpty);
      });

      test('nextState returns non-empty string', () {
        expect(faker.nextState(), isNotEmpty);
      });

      test('nextStateAbbreviation returns non-empty string', () {
        expect(faker.nextStateAbbreviation(), isNotEmpty);
      });

      test('nextCountry returns non-empty string', () {
        expect(faker.nextCountry(), isNotEmpty);
      });

      test('nextCountryCode returns non-empty string', () {
        expect(faker.nextCountryCode(), isNotEmpty);
      });

      test('nextContinent returns non-empty string', () {
        expect(faker.nextContinent(), isNotEmpty);
      });
    });

    group('Company', () {
      test('nextCompanyName returns non-empty string', () {
        expect(faker.nextCompanyName(), isNotEmpty);
      });

      test('nextCompanyPosition returns non-empty string', () {
        expect(faker.nextCompanyPosition(), isNotEmpty);
      });

      test('nextCompanySuffix returns non-empty string', () {
        expect(faker.nextCompanySuffix(), isNotEmpty);
      });
    });

    group('Lorem', () {
      test('nextWord returns non-empty string', () {
        expect(faker.nextWord(), isNotEmpty);
      });

      test('nextWords returns list of specified count', () {
        expect(faker.nextWords(count: 5).length, equals(5));
      });

      test('nextSentence returns non-empty string', () {
        expect(faker.nextSentence(), isNotEmpty);
      });

      test('nextSentences returns list of specified count', () {
        expect(faker.nextSentences(count: 3).length, equals(3));
      });

      test('nextParagraph returns non-empty string', () {
        expect(faker.nextParagraph(), isNotEmpty);
      });
    });

    group('Phone', () {
      test('nextPhoneNumber returns non-empty string', () {
        expect(faker.nextPhoneNumber(), isNotEmpty);
      });
    });

    group('Currency', () {
      test('nextCurrencyCode returns non-empty string', () {
        expect(faker.nextCurrencyCode(), isNotEmpty);
      });

      test('nextCurrencyName returns non-empty string', () {
        expect(faker.nextCurrencyName(), isNotEmpty);
      });
    });

    group('Color', () {
      test('nextColor returns non-empty string', () {
        expect(faker.nextColor(), isNotEmpty);
      });

      test('nextCommonColor returns non-empty string', () {
        expect(faker.nextCommonColor(), isNotEmpty);
      });

      test('nextRgbColor returns non-empty string', () {
        expect(faker.nextRgbColor(), isNotEmpty);
      });
    });

    group('Food', () {
      test('nextRestaurant returns non-empty string', () {
        expect(faker.nextRestaurant(), isNotEmpty);
      });

      test('nextDish returns non-empty string', () {
        expect(faker.nextDish(), isNotEmpty);
      });

      test('nextCuisine returns non-empty string', () {
        expect(faker.nextCuisine(), isNotEmpty);
      });
    });

    group('Sport', () {
      test('nextSport returns non-empty string', () {
        expect(faker.nextSport(), isNotEmpty);
      });
    });

    group('Animal', () {
      test('nextAnimal returns non-empty string', () {
        expect(faker.nextAnimal(), isNotEmpty);
      });
    });

    group('Vehicle', () {
      test('nextVehicleMake returns non-empty string', () {
        expect(faker.nextVehicleMake(), isNotEmpty);
      });

      test('nextVehicleModel returns non-empty string', () {
        expect(faker.nextVehicleModel(), isNotEmpty);
      });

      test('nextVehicleYear returns non-empty string', () {
        expect(faker.nextVehicleYear(), isNotEmpty);
      });

      test('nextVehicleYearMakeModel returns non-empty string', () {
        expect(faker.nextVehicleYearMakeModel(), isNotEmpty);
      });

      test('nextVehicleVin returns non-empty string', () {
        expect(faker.nextVehicleVin(), isNotEmpty);
      });
    });

    group('Conference', () {
      test('nextConference returns non-empty string', () {
        expect(faker.nextConference(), isNotEmpty);
      });
    });

    group('Geo', () {
      test('nextLatitude returns value in valid range', () {
        for (var i = 0; i < 100; i++) {
          final value = faker.nextLatitude();
          expect(value, greaterThanOrEqualTo(-90.0));
          expect(value, lessThanOrEqualTo(90.0));
        }
      });

      test('nextLongitude returns value in valid range', () {
        for (var i = 0; i < 100; i++) {
          final value = faker.nextLongitude();
          expect(value, greaterThanOrEqualTo(-180.0));
          expect(value, lessThanOrEqualTo(180.0));
        }
      });
    });

    group('JWT', () {
      test('nextJwtValid returns non-empty string', () {
        expect(faker.nextJwtValid(), isNotEmpty);
      });

      test('nextJwtExpired returns non-empty string', () {
        expect(faker.nextJwtExpired(), isNotEmpty);
      });
    });

    group('Image', () {
      test('nextImageUrl returns valid URL', () {
        final value = faker.nextImageUrl();
        expect(value, startsWith('https://'));
      });

      test('nextImageUrl with custom dimensions includes dimensions', () {
        final value = faker.nextImageUrl(width: 800, height: 600);
        expect(value, contains('800'));
        expect(value, contains('600'));
      });
    });

    group('Reproducibility', () {
      test('same seed produces same sequence', () {
        final r1 = Faker(seed: 123);
        final r2 = Faker(seed: 123);

        expect(r1.nextInt(), equals(r2.nextInt()));
        expect(r1.nextDouble(), equals(r2.nextDouble()));
        expect(r1.nextBool(), equals(r2.nextBool()));
        expect(r1.nextString(), equals(r2.nextString()));
      });

      test('different seeds produce different sequences', () {
        final r1 = Faker(seed: 123);
        final r2 = Faker(seed: 456);

        // Collect multiple values to ensure they're different (not just by chance)
        final ints1 = List.generate(10, (_) => r1.nextInt());
        final ints2 = List.generate(10, (_) => r2.nextInt());

        expect(ints1, isNot(equals(ints2)));
      });
    });
  });
}

enum TestEnum { value1, value2, value3 }
