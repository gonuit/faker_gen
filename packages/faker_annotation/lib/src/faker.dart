import 'dart:math';

import 'package:faker/faker.dart' as faker_lib;

/// Generates random/fake values for testing. Wraps the `faker` package.
class Faker {
  /// Creates a Faker with optional [seed] for reproducible values.
  Faker({int? seed})
    : _random = Random(seed),
      _faker = faker_lib.Faker(seed: seed);

  final Random _random;
  final faker_lib.Faker _faker;

  // ─── Primitives ────────────────────────────────────────────────────────────

  /// Random integer in range [min, max).
  int nextInt({int min = 0, int max = 4294967296}) =>
      min + _random.nextInt(max - min);

  /// Random double in range [min, max).
  double nextDouble({double min = 0.0, double max = 1.0}) =>
      min + _random.nextDouble() * (max - min);

  /// Random boolean.
  bool nextBool() => _random.nextBool();

  /// Random num (int or double).
  num nextNum({num min = 0, num max = 100}) =>
      nextBool()
          ? nextDouble(min: min.toDouble(), max: max.toDouble())
          : nextInt(min: min.toInt(), max: max.toInt());

  /// Random enum value from [values].
  T nextEnum<T extends Enum>(List<T> values) =>
      values[_random.nextInt(values.length)];

  /// Random item from [items].
  T nextFromList<T>(List<T> items) => items[_random.nextInt(items.length)];

  /// List of random items using [generator].
  List<T> nextListOf<T>(
    T Function() generator, {
    int minLength = 1,
    int maxLength = 5,
  }) => List.generate(
    nextInt(min: minLength, max: maxLength),
    (_) => generator(),
  );

  /// Nullable value with [nullWeight] probability of being null.
  T? nextNullable<T>(T Function() generator, {double nullWeight = 0.3}) =>
      _random.nextDouble() < nullWeight ? null : generator();

  // ─── String ────────────────────────────────────────────────────────────────

  /// Random word with optional [prefix].
  String nextString({String prefix = ''}) => '$prefix${_faker.lorem.word()}';

  /// Random UUID v4.
  String nextUuid() => _faker.guid.guid();

  // ─── DateTime ──────────────────────────────────────────────────────────────

  /// Random DateTime between [minYear] and [maxYear].
  DateTime nextDateTime({int minYear = 2000, int maxYear = 2030}) =>
      _faker.date.dateTime(minYear: minYear, maxYear: maxYear);

  /// Random DateTime between [start] and [end].
  DateTime nextDateTimeBetween(DateTime start, DateTime end) =>
      _faker.date.dateTimeBetween(start, end);

  /// Random month name (e.g., "January").
  String nextMonth() => _faker.date.month();

  /// Random year string between [minYear] and [maxYear].
  String nextYear({int minYear = 2000, int maxYear = 2030}) =>
      _faker.date.year(minYear: minYear, maxYear: maxYear);

  /// Random time string (e.g., "14:30").
  String nextTime() => _faker.date.time();

  // ─── Person ────────────────────────────────────────────────────────────────

  /// Random first name.
  String nextFirstName() => _faker.person.firstName();

  /// Random last name.
  String nextLastName() => _faker.person.lastName();

  /// Random full name.
  String nextFullName() => _faker.person.name();

  /// Random name prefix (e.g., "Mr.", "Dr.").
  String nextPersonPrefix() => _faker.person.prefix();

  /// Random name suffix (e.g., "Jr.", "PhD").
  String nextPersonSuffix() => _faker.person.suffix();

  // ─── Job ───────────────────────────────────────────────────────────────────

  /// Random job title.
  String nextJobTitle() => _faker.job.title();

  // ─── Internet ──────────────────────────────────────────────────────────────

  /// Random email address.
  String nextEmail() => _faker.internet.email();

  /// Random free email (gmail, yahoo, etc.).
  String nextFreeEmail() => _faker.internet.freeEmail();

  /// Random safe email (example.com domain).
  String nextSafeEmail() => _faker.internet.safeEmail();

  /// Random disposable email.
  String nextDisposableEmail() => _faker.internet.disposableEmail();

  /// Random username.
  String nextUsername() => _faker.internet.userName();

  /// Random domain name.
  String nextDomainName() => _faker.internet.domainName();

  /// Random domain word.
  String nextDomainWord() => _faker.internet.domainWord();

  /// Random HTTPS URL.
  String nextUrl() => _faker.internet.httpsUrl();

  /// Random HTTP URL.
  String nextHttpUrl() => _faker.internet.httpUrl();

  /// Random HTTPS URL.
  String nextHttpsUrl() => _faker.internet.httpsUrl();

  /// Random URI with [protocol].
  String nextUri(String protocol) => _faker.internet.uri(protocol);

  /// Random IPv4 address.
  String nextIpv4Address() => _faker.internet.ipv4Address();

  /// Random IPv6 address.
  String nextIpv6Address() => _faker.internet.ipv6Address();

  /// Random MAC address.
  String nextMacAddress() => _faker.internet.macAddress();

  /// Random password with [length].
  String nextPassword({int length = 10}) =>
      _faker.internet.password(length: length);

  /// Random user agent string.
  String nextUserAgent({String osName = ''}) =>
      _faker.internet.userAgent(osName: osName);

  // ─── Address ───────────────────────────────────────────────────────────────

  /// Random zip/postal code.
  String nextZipCode() => _faker.address.zipCode();

  /// Random city name.
  String nextCity() => _faker.address.city();

  /// Random city prefix.
  String nextCityPrefix() => _faker.address.cityPrefix();

  /// Random city suffix.
  String nextCitySuffix() => _faker.address.citySuffix();

  /// Random street name.
  String nextStreetName() => _faker.address.streetName();

  /// Random full street address.
  String nextStreetAddress() => _faker.address.streetAddress();

  /// Random street suffix.
  String nextStreetSuffix() => _faker.address.streetSuffix();

  /// Random building number.
  String nextBuildingNumber() => _faker.address.buildingNumber();

  /// Random neighborhood name.
  String nextNeighborhood() => _faker.address.neighborhood();

  /// Random state name.
  String nextState() => _faker.address.state();

  /// Random state abbreviation (e.g., "CA").
  String nextStateAbbreviation() => _faker.address.stateAbbreviation();

  /// Random country name.
  String nextCountry() => _faker.address.country();

  /// Random country code (e.g., "US").
  String nextCountryCode() => _faker.address.countryCode();

  /// Random continent name.
  String nextContinent() => _faker.address.continent();

  // ─── Company ───────────────────────────────────────────────────────────────

  /// Random company name.
  String nextCompanyName() => _faker.company.name();

  /// Random company position/role.
  String nextCompanyPosition() => _faker.company.position();

  /// Random company suffix (e.g., "Inc.", "LLC").
  String nextCompanySuffix() => _faker.company.suffix();

  // ─── Lorem ─────────────────────────────────────────────────────────────────

  /// Random lorem word.
  String nextWord() => _faker.lorem.word();

  /// List of [count] random words.
  List<String> nextWords({int count = 3}) => _faker.lorem.words(count);

  /// Random sentence.
  String nextSentence() => _faker.lorem.sentence();

  /// List of [count] random sentences.
  List<String> nextSentences({int count = 3}) => _faker.lorem.sentences(count);

  /// Random paragraph (3 sentences).
  String nextParagraph() => _faker.lorem.sentences(3).join(' ');

  // ─── Phone ─────────────────────────────────────────────────────────────────

  /// Random US phone number.
  String nextPhoneNumber() => _faker.phoneNumber.us();

  // ─── Currency ──────────────────────────────────────────────────────────────

  /// Random currency code (e.g., "USD").
  String nextCurrencyCode() => _faker.currency.code();

  /// Random currency name (e.g., "US Dollar").
  String nextCurrencyName() => _faker.currency.name();

  // ─── Color ─────────────────────────────────────────────────────────────────

  /// Random color name.
  String nextColor() => _faker.color.color();

  /// Random common color name.
  String nextCommonColor() => _faker.color.commonColor();

  /// Random RGB color string.
  String nextRgbColor() => _faker.color.rgbColor();

  // ─── Food ──────────────────────────────────────────────────────────────────

  /// Random restaurant name.
  String nextRestaurant() => _faker.food.restaurant();

  /// Random dish name.
  String nextDish() => _faker.food.dish();

  /// Random cuisine type.
  String nextCuisine() => _faker.food.cuisine();

  // ─── Sport ─────────────────────────────────────────────────────────────────

  /// Random sport name.
  String nextSport() => _faker.sport.name();

  // ─── Animal ────────────────────────────────────────────────────────────────

  /// Random animal name.
  String nextAnimal() => _faker.animal.name();

  // ─── Vehicle ───────────────────────────────────────────────────────────────

  /// Random vehicle make (e.g., "Toyota").
  String nextVehicleMake() => _faker.vehicle.make();

  /// Random vehicle model (e.g., "Corolla").
  String nextVehicleModel() => _faker.vehicle.model();

  /// Random vehicle year.
  String nextVehicleYear() => _faker.vehicle.year();

  /// Random year + make + model string.
  String nextVehicleYearMakeModel() => _faker.vehicle.yearMakeModel();

  /// Random vehicle VIN.
  String nextVehicleVin() => _faker.vehicle.vin();

  // ─── Conference ────────────────────────────────────────────────────────────

  /// Random conference name.
  String nextConference() => _faker.conference.name();

  // ─── Geo ───────────────────────────────────────────────────────────────────

  /// Random latitude (-90 to 90).
  double nextLatitude() => _faker.geo.latitude();

  /// Random longitude (-180 to 180).
  double nextLongitude() => _faker.geo.longitude();

  // ─── JWT ───────────────────────────────────────────────────────────────────

  /// Random valid JWT token.
  String nextJwtValid({DateTime? expiresIn}) =>
      _faker.jwt.valid(expiresIn: expiresIn);

  /// Random expired JWT token.
  String nextJwtExpired({DateTime? expiresIn}) =>
      _faker.jwt.expired(expiresIn: expiresIn);

  // ─── Image ─────────────────────────────────────────────────────────────────

  /// Random placeholder image URL.
  String nextImageUrl({
    int width = 640,
    int height = 480,
    int? random,
    String? seed,
  }) => _faker.image.loremPicsum(
    width: width,
    height: height,
    random: random,
    seed: seed,
  );
}
