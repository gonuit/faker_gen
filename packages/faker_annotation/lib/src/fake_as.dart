import 'package:meta/meta_meta.dart';

/// Specifies which [Faker] method to use for generating fake field values.
///
/// All annotations use named constructor syntax for consistency.
///
/// ```dart
/// @FakeIt()
/// class User {
///   @FakeAs.firstName()
///   final String name;
///
///   @FakeAs.email()
///   final String email;
///
///   @FakeAs.latitude()
///   final double lat;
///
///   @FakeAs.password(length: 20)
///   final String secret;
///
///   @FakeAs.words(count: 5)
///   final List<String> tags;
///
///   @FakeAs.integer(min: 18, max: 65)
///   final int age;
/// }
/// ```
@Target({TargetKind.field})
class FakeAs {
  /// The Faker method name to call.
  final String method;

  /// Expected return type for validation.
  final String returnType;

  /// Optional arguments to pass to the method.
  final String? args;

  // ─── String ────────────────────────────────────────────────────────────────

  /// Random word with optional [prefix].
  const FakeAs.string({String? prefix})
    : method = 'nextString',
      returnType = 'String',
      args = prefix != null ? "prefix: '$prefix'" : null;

  /// Random UUID v4.
  const FakeAs.uuid() : method = 'nextUuid', returnType = 'String', args = null;

  // ─── DateTime ──────────────────────────────────────────────────────────────

  /// Random DateTime in [minYear]-[maxYear] range.
  const FakeAs.dateTime({int minYear = 2000, int maxYear = 2030})
    : method = 'nextDateTime',
      returnType = 'DateTime',
      args = 'minYear: $minYear, maxYear: $maxYear';

  /// Random month name.
  const FakeAs.month()
    : method = 'nextMonth',
      returnType = 'String',
      args = null;

  /// Random year string.
  const FakeAs.year() : method = 'nextYear', returnType = 'String', args = null;

  /// Random time string.
  const FakeAs.time() : method = 'nextTime', returnType = 'String', args = null;

  // ─── Person ────────────────────────────────────────────────────────────────

  /// Random first name.
  const FakeAs.firstName()
    : method = 'nextFirstName',
      returnType = 'String',
      args = null;

  /// Random last name.
  const FakeAs.lastName()
    : method = 'nextLastName',
      returnType = 'String',
      args = null;

  /// Random full name.
  const FakeAs.fullName()
    : method = 'nextFullName',
      returnType = 'String',
      args = null;

  /// Random name prefix (Mr., Dr., etc.).
  const FakeAs.personPrefix()
    : method = 'nextPersonPrefix',
      returnType = 'String',
      args = null;

  /// Random name suffix (Jr., PhD, etc.).
  const FakeAs.personSuffix()
    : method = 'nextPersonSuffix',
      returnType = 'String',
      args = null;

  // ─── Job ───────────────────────────────────────────────────────────────────

  /// Random job title.
  const FakeAs.jobTitle()
    : method = 'nextJobTitle',
      returnType = 'String',
      args = null;

  // ─── Internet ──────────────────────────────────────────────────────────────

  /// Random email address.
  const FakeAs.email()
    : method = 'nextEmail',
      returnType = 'String',
      args = null;

  /// Random free email (gmail, yahoo, etc.).
  const FakeAs.freeEmail()
    : method = 'nextFreeEmail',
      returnType = 'String',
      args = null;

  /// Random safe email (example.com).
  const FakeAs.safeEmail()
    : method = 'nextSafeEmail',
      returnType = 'String',
      args = null;

  /// Random disposable email.
  const FakeAs.disposableEmail()
    : method = 'nextDisposableEmail',
      returnType = 'String',
      args = null;

  /// Random username.
  const FakeAs.username()
    : method = 'nextUsername',
      returnType = 'String',
      args = null;

  /// Random domain name.
  const FakeAs.domainName()
    : method = 'nextDomainName',
      returnType = 'String',
      args = null;

  /// Random domain word.
  const FakeAs.domainWord()
    : method = 'nextDomainWord',
      returnType = 'String',
      args = null;

  /// Random HTTPS URL.
  const FakeAs.url() : method = 'nextUrl', returnType = 'String', args = null;

  /// Random HTTP URL.
  const FakeAs.httpUrl()
    : method = 'nextHttpUrl',
      returnType = 'String',
      args = null;

  /// Random HTTPS URL.
  const FakeAs.httpsUrl()
    : method = 'nextHttpsUrl',
      returnType = 'String',
      args = null;

  /// Random IPv4 address.
  const FakeAs.ipv4Address()
    : method = 'nextIpv4Address',
      returnType = 'String',
      args = null;

  /// Random IPv6 address.
  const FakeAs.ipv6Address()
    : method = 'nextIpv6Address',
      returnType = 'String',
      args = null;

  /// Random MAC address.
  const FakeAs.macAddress()
    : method = 'nextMacAddress',
      returnType = 'String',
      args = null;

  /// Random password with optional [length] (default: 10).
  const FakeAs.password({int length = 10})
    : method = 'nextPassword',
      returnType = 'String',
      args = 'length: $length';

  /// Random user agent string.
  const FakeAs.userAgent()
    : method = 'nextUserAgent',
      returnType = 'String',
      args = null;

  // ─── Address ───────────────────────────────────────────────────────────────

  /// Random zip/postal code.
  const FakeAs.zipCode()
    : method = 'nextZipCode',
      returnType = 'String',
      args = null;

  /// Random city name.
  const FakeAs.city() : method = 'nextCity', returnType = 'String', args = null;

  /// Random city prefix.
  const FakeAs.cityPrefix()
    : method = 'nextCityPrefix',
      returnType = 'String',
      args = null;

  /// Random city suffix.
  const FakeAs.citySuffix()
    : method = 'nextCitySuffix',
      returnType = 'String',
      args = null;

  /// Random street name.
  const FakeAs.streetName()
    : method = 'nextStreetName',
      returnType = 'String',
      args = null;

  /// Random full street address.
  const FakeAs.streetAddress()
    : method = 'nextStreetAddress',
      returnType = 'String',
      args = null;

  /// Random street suffix.
  const FakeAs.streetSuffix()
    : method = 'nextStreetSuffix',
      returnType = 'String',
      args = null;

  /// Random building number.
  const FakeAs.buildingNumber()
    : method = 'nextBuildingNumber',
      returnType = 'String',
      args = null;

  /// Random neighborhood name.
  const FakeAs.neighborhood()
    : method = 'nextNeighborhood',
      returnType = 'String',
      args = null;

  /// Random state name.
  const FakeAs.state()
    : method = 'nextState',
      returnType = 'String',
      args = null;

  /// Random state abbreviation (CA, NY, etc.).
  const FakeAs.stateAbbreviation()
    : method = 'nextStateAbbreviation',
      returnType = 'String',
      args = null;

  /// Random country name.
  const FakeAs.country()
    : method = 'nextCountry',
      returnType = 'String',
      args = null;

  /// Random country code (US, DE, etc.).
  const FakeAs.countryCode()
    : method = 'nextCountryCode',
      returnType = 'String',
      args = null;

  /// Random continent name.
  const FakeAs.continent()
    : method = 'nextContinent',
      returnType = 'String',
      args = null;

  // ─── Company ───────────────────────────────────────────────────────────────

  /// Random company name.
  const FakeAs.companyName()
    : method = 'nextCompanyName',
      returnType = 'String',
      args = null;

  /// Random company position/role.
  const FakeAs.companyPosition()
    : method = 'nextCompanyPosition',
      returnType = 'String',
      args = null;

  /// Random company suffix (Inc., LLC, etc.).
  const FakeAs.companySuffix()
    : method = 'nextCompanySuffix',
      returnType = 'String',
      args = null;

  // ─── Lorem ─────────────────────────────────────────────────────────────────

  /// Random lorem word.
  const FakeAs.word() : method = 'nextWord', returnType = 'String', args = null;

  /// List of random words with optional [count] (default: 3).
  const FakeAs.words({int count = 3})
    : method = 'nextWords',
      returnType = 'List<String>',
      args = 'count: $count';

  /// Random sentence.
  const FakeAs.sentence()
    : method = 'nextSentence',
      returnType = 'String',
      args = null;

  /// List of random sentences with optional [count] (default: 3).
  const FakeAs.sentences({int count = 3})
    : method = 'nextSentences',
      returnType = 'List<String>',
      args = 'count: $count';

  /// Random paragraph.
  const FakeAs.paragraph()
    : method = 'nextParagraph',
      returnType = 'String',
      args = null;

  // ─── Phone ─────────────────────────────────────────────────────────────────

  /// Random phone number.
  const FakeAs.phoneNumber()
    : method = 'nextPhoneNumber',
      returnType = 'String',
      args = null;

  // ─── Currency ──────────────────────────────────────────────────────────────

  /// Random currency code (USD, EUR, etc.).
  const FakeAs.currencyCode()
    : method = 'nextCurrencyCode',
      returnType = 'String',
      args = null;

  /// Random currency name.
  const FakeAs.currencyName()
    : method = 'nextCurrencyName',
      returnType = 'String',
      args = null;

  // ─── Color ─────────────────────────────────────────────────────────────────

  /// Random color name.
  const FakeAs.color()
    : method = 'nextColor',
      returnType = 'String',
      args = null;

  /// Random common color name.
  const FakeAs.commonColor()
    : method = 'nextCommonColor',
      returnType = 'String',
      args = null;

  /// Random RGB color string.
  const FakeAs.rgbColor()
    : method = 'nextRgbColor',
      returnType = 'String',
      args = null;

  // ─── Food ──────────────────────────────────────────────────────────────────

  /// Random restaurant name.
  const FakeAs.restaurant()
    : method = 'nextRestaurant',
      returnType = 'String',
      args = null;

  /// Random dish name.
  const FakeAs.dish() : method = 'nextDish', returnType = 'String', args = null;

  /// Random cuisine type.
  const FakeAs.cuisine()
    : method = 'nextCuisine',
      returnType = 'String',
      args = null;

  // ─── Sport ─────────────────────────────────────────────────────────────────

  /// Random sport name.
  const FakeAs.sport()
    : method = 'nextSport',
      returnType = 'String',
      args = null;

  // ─── Animal ────────────────────────────────────────────────────────────────

  /// Random animal name.
  const FakeAs.animal()
    : method = 'nextAnimal',
      returnType = 'String',
      args = null;

  // ─── Vehicle ───────────────────────────────────────────────────────────────

  /// Random vehicle make (Toyota, Ford, etc.).
  const FakeAs.vehicleMake()
    : method = 'nextVehicleMake',
      returnType = 'String',
      args = null;

  /// Random vehicle model.
  const FakeAs.vehicleModel()
    : method = 'nextVehicleModel',
      returnType = 'String',
      args = null;

  /// Random vehicle year.
  const FakeAs.vehicleYear()
    : method = 'nextVehicleYear',
      returnType = 'String',
      args = null;

  /// Random year + make + model string.
  const FakeAs.vehicleYearMakeModel()
    : method = 'nextVehicleYearMakeModel',
      returnType = 'String',
      args = null;

  /// Random vehicle VIN.
  const FakeAs.vehicleVin()
    : method = 'nextVehicleVin',
      returnType = 'String',
      args = null;

  // ─── Conference ────────────────────────────────────────────────────────────

  /// Random conference name.
  const FakeAs.conference()
    : method = 'nextConference',
      returnType = 'String',
      args = null;

  // ─── Geo ───────────────────────────────────────────────────────────────────

  /// Random latitude (-90 to 90).
  const FakeAs.latitude()
    : method = 'nextLatitude',
      returnType = 'double',
      args = null;

  /// Random longitude (-180 to 180).
  const FakeAs.longitude()
    : method = 'nextLongitude',
      returnType = 'double',
      args = null;

  // ─── JWT ───────────────────────────────────────────────────────────────────

  /// Random valid JWT token.
  const FakeAs.jwtValid()
    : method = 'nextJwtValid',
      returnType = 'String',
      args = null;

  /// Random expired JWT token.
  const FakeAs.jwtExpired()
    : method = 'nextJwtExpired',
      returnType = 'String',
      args = null;

  // ─── Image ─────────────────────────────────────────────────────────────────

  /// Random placeholder image URL with optional [width] and [height].
  const FakeAs.imageUrl({int width = 640, int height = 480})
    : method = 'nextImageUrl',
      returnType = 'String',
      args = 'width: $width, height: $height';

  // ─── Primitives ────────────────────────────────────────────────────────────

  /// Random integer in range [[min], [max]). Defaults to [0, 2^32).
  const FakeAs.integer({int? min, int? max})
    : method = 'nextInt',
      returnType = 'int',
      args =
          min != null || max != null
              ? '${min != null ? 'min: $min' : ''}${min != null && max != null ? ', ' : ''}${max != null ? 'max: $max' : ''}'
              : null;

  /// Random double in range [[min], [max]). Defaults to [0.0, 1.0).
  const FakeAs.decimal({double? min, double? max})
    : method = 'nextDouble',
      returnType = 'double',
      args =
          min != null || max != null
              ? '${min != null ? 'min: $min' : ''}${min != null && max != null ? ', ' : ''}${max != null ? 'max: $max' : ''}'
              : null;
}
