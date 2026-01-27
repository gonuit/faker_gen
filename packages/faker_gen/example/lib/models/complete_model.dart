import 'package:faker_annotation/faker_annotation.dart';

part 'complete_model.g.dart';

/// A comprehensive model demonstrating all FakeAs annotation types.
///
/// This model showcases every available FakeAs generator for fake data.
@FakeIt()
class CompleteModel {
  // ─── String Basics ─────────────────────────────────────────────────────────

  @FakeAs.string()
  final String randomString;

  @FakeAs.string(prefix: 'user_')
  final String prefixedString;

  @FakeAs.uuid()
  final String uuid;

  // ─── DateTime ──────────────────────────────────────────────────────────────

  @FakeAs.dateTime()
  final DateTime createdAt;

  @FakeAs.dateTime(minYear: 1990, maxYear: 2000)
  final DateTime birthDate;

  @FakeAs.month()
  final String birthMonth;

  @FakeAs.year()
  final String graduationYear;

  @FakeAs.time()
  final String meetingTime;

  // ─── Person ────────────────────────────────────────────────────────────────

  @FakeAs.firstName()
  final String firstName;

  @FakeAs.lastName()
  final String lastName;

  @FakeAs.fullName()
  final String fullName;

  @FakeAs.personPrefix()
  final String namePrefix;

  @FakeAs.personSuffix()
  final String nameSuffix;

  // ─── Job ───────────────────────────────────────────────────────────────────

  @FakeAs.jobTitle()
  final String jobTitle;

  // ─── Internet ──────────────────────────────────────────────────────────────

  @FakeAs.email()
  final String email;

  @FakeAs.freeEmail()
  final String freeEmail;

  @FakeAs.safeEmail()
  final String safeEmail;

  @FakeAs.disposableEmail()
  final String disposableEmail;

  @FakeAs.username()
  final String username;

  @FakeAs.domainName()
  final String domainName;

  @FakeAs.domainWord()
  final String domainWord;

  @FakeAs.url()
  final String url;

  @FakeAs.httpUrl()
  final String httpUrl;

  @FakeAs.httpsUrl()
  final String httpsUrl;

  @FakeAs.ipv4Address()
  final String ipv4;

  @FakeAs.ipv6Address()
  final String ipv6;

  @FakeAs.macAddress()
  final String macAddress;

  @FakeAs.password()
  final String password;

  @FakeAs.password(length: 20)
  final String longPassword;

  @FakeAs.userAgent()
  final String userAgent;

  // ─── Address ───────────────────────────────────────────────────────────────

  @FakeAs.zipCode()
  final String zipCode;

  @FakeAs.city()
  final String city;

  @FakeAs.cityPrefix()
  final String cityPrefix;

  @FakeAs.citySuffix()
  final String citySuffix;

  @FakeAs.streetName()
  final String streetName;

  @FakeAs.streetAddress()
  final String streetAddress;

  @FakeAs.streetSuffix()
  final String streetSuffix;

  @FakeAs.buildingNumber()
  final String buildingNumber;

  @FakeAs.neighborhood()
  final String neighborhood;

  @FakeAs.state()
  final String state;

  @FakeAs.stateAbbreviation()
  final String stateAbbr;

  @FakeAs.country()
  final String country;

  @FakeAs.countryCode()
  final String countryCode;

  @FakeAs.continent()
  final String continent;

  // ─── Company ───────────────────────────────────────────────────────────────

  @FakeAs.companyName()
  final String companyName;

  @FakeAs.companyPosition()
  final String companyPosition;

  @FakeAs.companySuffix()
  final String companySuffix;

  // ─── Lorem ─────────────────────────────────────────────────────────────────

  @FakeAs.word()
  final String word;

  @FakeAs.words()
  final List<String> words;

  @FakeAs.words(count: 5)
  final List<String> fiveWords;

  @FakeAs.sentence()
  final String sentence;

  @FakeAs.sentences()
  final List<String> sentences;

  @FakeAs.sentences(count: 5)
  final List<String> fiveSentences;

  @FakeAs.paragraph()
  final String paragraph;

  // ─── Phone ─────────────────────────────────────────────────────────────────

  @FakeAs.phoneNumber()
  final String phoneNumber;

  // ─── Currency ──────────────────────────────────────────────────────────────

  @FakeAs.currencyCode()
  final String currencyCode;

  @FakeAs.currencyName()
  final String currencyName;

  // ─── Color ─────────────────────────────────────────────────────────────────

  @FakeAs.color()
  final String color;

  @FakeAs.commonColor()
  final String commonColor;

  @FakeAs.rgbColor()
  final String rgbColor;

  // ─── Food ──────────────────────────────────────────────────────────────────

  @FakeAs.restaurant()
  final String restaurant;

  @FakeAs.dish()
  final String dish;

  @FakeAs.cuisine()
  final String cuisine;

  // ─── Sport ─────────────────────────────────────────────────────────────────

  @FakeAs.sport()
  final String sport;

  // ─── Animal ────────────────────────────────────────────────────────────────

  @FakeAs.animal()
  final String animal;

  // ─── Vehicle ───────────────────────────────────────────────────────────────

  @FakeAs.vehicleMake()
  final String vehicleMake;

  @FakeAs.vehicleModel()
  final String vehicleModel;

  @FakeAs.vehicleYear()
  final String vehicleYear;

  @FakeAs.vehicleYearMakeModel()
  final String vehicleYearMakeModel;

  @FakeAs.vehicleVin()
  final String vehicleVin;

  // ─── Conference ────────────────────────────────────────────────────────────

  @FakeAs.conference()
  final String conference;

  // ─── Geo ───────────────────────────────────────────────────────────────────

  @FakeAs.latitude()
  final double latitude;

  @FakeAs.longitude()
  final double longitude;

  // ─── JWT ───────────────────────────────────────────────────────────────────

  @FakeAs.jwtValid()
  final String jwtValid;

  @FakeAs.jwtExpired()
  final String jwtExpired;

  // ─── Image ─────────────────────────────────────────────────────────────────

  @FakeAs.imageUrl()
  final String imageUrl;

  @FakeAs.imageUrl(width: 100, height: 100)
  final String thumbnailUrl;

  // ─── Primitives ────────────────────────────────────────────────────────────

  @FakeAs.integer()
  final int randomInt;

  @FakeAs.integer(min: 1, max: 100)
  final int boundedInt;

  @FakeAs.integer(min: 18)
  final int minOnlyInt;

  @FakeAs.integer(max: 10)
  final int maxOnlyInt;

  @FakeAs.decimal()
  final double randomDouble;

  @FakeAs.decimal(min: 0.0, max: 1.0)
  final double percentage;

  @FakeAs.decimal(min: 9.99, max: 999.99)
  final double price;

  CompleteModel({
    required this.randomString,
    required this.prefixedString,
    required this.uuid,
    required this.createdAt,
    required this.birthDate,
    required this.birthMonth,
    required this.graduationYear,
    required this.meetingTime,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.namePrefix,
    required this.nameSuffix,
    required this.jobTitle,
    required this.email,
    required this.freeEmail,
    required this.safeEmail,
    required this.disposableEmail,
    required this.username,
    required this.domainName,
    required this.domainWord,
    required this.url,
    required this.httpUrl,
    required this.httpsUrl,
    required this.ipv4,
    required this.ipv6,
    required this.macAddress,
    required this.password,
    required this.longPassword,
    required this.userAgent,
    required this.zipCode,
    required this.city,
    required this.cityPrefix,
    required this.citySuffix,
    required this.streetName,
    required this.streetAddress,
    required this.streetSuffix,
    required this.buildingNumber,
    required this.neighborhood,
    required this.state,
    required this.stateAbbr,
    required this.country,
    required this.countryCode,
    required this.continent,
    required this.companyName,
    required this.companyPosition,
    required this.companySuffix,
    required this.word,
    required this.words,
    required this.fiveWords,
    required this.sentence,
    required this.sentences,
    required this.fiveSentences,
    required this.paragraph,
    required this.phoneNumber,
    required this.currencyCode,
    required this.currencyName,
    required this.color,
    required this.commonColor,
    required this.rgbColor,
    required this.restaurant,
    required this.dish,
    required this.cuisine,
    required this.sport,
    required this.animal,
    required this.vehicleMake,
    required this.vehicleModel,
    required this.vehicleYear,
    required this.vehicleYearMakeModel,
    required this.vehicleVin,
    required this.conference,
    required this.latitude,
    required this.longitude,
    required this.jwtValid,
    required this.jwtExpired,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.randomInt,
    required this.boundedInt,
    required this.minOnlyInt,
    required this.maxOnlyInt,
    required this.randomDouble,
    required this.percentage,
    required this.price,
  });
}
