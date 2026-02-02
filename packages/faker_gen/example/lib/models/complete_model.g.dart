// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_model.dart';

// **************************************************************************
// FakerGenerator
// **************************************************************************

// ignore_for_file: unused_element
// ignore_for_file: library_private_types_in_public_api

/// Creates a fake instance of [CompleteModel] with random or provided values.
///
/// All parameters are optional:
/// - Not provided: A random value is generated
/// - Explicitly provided: The provided value is used
/// - Explicitly null (for nullable fields): null is set
///
/// [faker] - Optional [Faker] instance for reproducible random values.
abstract class _$FakeCompleteModel {
  CompleteModel call({
    Faker? faker,
    String randomString,
    String prefixedString,
    String uuid,
    DateTime createdAt,
    DateTime birthDate,
    String birthMonth,
    String graduationYear,
    String meetingTime,
    String firstName,
    String lastName,
    String fullName,
    String namePrefix,
    String nameSuffix,
    String jobTitle,
    String email,
    String freeEmail,
    String safeEmail,
    String disposableEmail,
    String username,
    String domainName,
    String domainWord,
    String url,
    String httpUrl,
    String httpsUrl,
    String ipv4,
    String ipv6,
    String macAddress,
    String password,
    String longPassword,
    String userAgent,
    String zipCode,
    String city,
    String cityPrefix,
    String citySuffix,
    String streetName,
    String streetAddress,
    String streetSuffix,
    String buildingNumber,
    String neighborhood,
    String state,
    String stateAbbr,
    String country,
    String countryCode,
    String continent,
    String companyName,
    String companyPosition,
    String companySuffix,
    String word,
    List<String> words,
    List<String> fiveWords,
    String sentence,
    List<String> sentences,
    List<String> fiveSentences,
    String paragraph,
    String phoneNumber,
    String currencyCode,
    String currencyName,
    String color,
    String commonColor,
    String rgbColor,
    String restaurant,
    String dish,
    String cuisine,
    String sport,
    String animal,
    String vehicleMake,
    String vehicleModel,
    String vehicleYear,
    String vehicleYearMakeModel,
    String vehicleVin,
    String conference,
    double latitude,
    double longitude,
    String jwtValid,
    String jwtExpired,
    String imageUrl,
    String thumbnailUrl,
    int randomInt,
    int boundedInt,
    int minOnlyInt,
    int maxOnlyInt,
    double randomDouble,
    double percentage,
    double price,
    String appVersion,
    String? deletedAt,
    Author author,
    Author systemAuthor,
    Author adminAuthor,
  });

  /// Generates [count] fake instances of [CompleteModel].
  Iterable<CompleteModel> many(int count, {Faker? faker});
}

class _$FakeCompleteModelImpl implements _$FakeCompleteModel {
  const _$FakeCompleteModelImpl();

  @override
  CompleteModel call({
    Faker? faker,
    Object randomString = $undefined,
    Object prefixedString = $undefined,
    Object uuid = $undefined,
    Object createdAt = $undefined,
    Object birthDate = $undefined,
    Object birthMonth = $undefined,
    Object graduationYear = $undefined,
    Object meetingTime = $undefined,
    Object firstName = $undefined,
    Object lastName = $undefined,
    Object fullName = $undefined,
    Object namePrefix = $undefined,
    Object nameSuffix = $undefined,
    Object jobTitle = $undefined,
    Object email = $undefined,
    Object freeEmail = $undefined,
    Object safeEmail = $undefined,
    Object disposableEmail = $undefined,
    Object username = $undefined,
    Object domainName = $undefined,
    Object domainWord = $undefined,
    Object url = $undefined,
    Object httpUrl = $undefined,
    Object httpsUrl = $undefined,
    Object ipv4 = $undefined,
    Object ipv6 = $undefined,
    Object macAddress = $undefined,
    Object password = $undefined,
    Object longPassword = $undefined,
    Object userAgent = $undefined,
    Object zipCode = $undefined,
    Object city = $undefined,
    Object cityPrefix = $undefined,
    Object citySuffix = $undefined,
    Object streetName = $undefined,
    Object streetAddress = $undefined,
    Object streetSuffix = $undefined,
    Object buildingNumber = $undefined,
    Object neighborhood = $undefined,
    Object state = $undefined,
    Object stateAbbr = $undefined,
    Object country = $undefined,
    Object countryCode = $undefined,
    Object continent = $undefined,
    Object companyName = $undefined,
    Object companyPosition = $undefined,
    Object companySuffix = $undefined,
    Object word = $undefined,
    Object words = $undefined,
    Object fiveWords = $undefined,
    Object sentence = $undefined,
    Object sentences = $undefined,
    Object fiveSentences = $undefined,
    Object paragraph = $undefined,
    Object phoneNumber = $undefined,
    Object currencyCode = $undefined,
    Object currencyName = $undefined,
    Object color = $undefined,
    Object commonColor = $undefined,
    Object rgbColor = $undefined,
    Object restaurant = $undefined,
    Object dish = $undefined,
    Object cuisine = $undefined,
    Object sport = $undefined,
    Object animal = $undefined,
    Object vehicleMake = $undefined,
    Object vehicleModel = $undefined,
    Object vehicleYear = $undefined,
    Object vehicleYearMakeModel = $undefined,
    Object vehicleVin = $undefined,
    Object conference = $undefined,
    Object latitude = $undefined,
    Object longitude = $undefined,
    Object jwtValid = $undefined,
    Object jwtExpired = $undefined,
    Object imageUrl = $undefined,
    Object thumbnailUrl = $undefined,
    Object randomInt = $undefined,
    Object boundedInt = $undefined,
    Object minOnlyInt = $undefined,
    Object maxOnlyInt = $undefined,
    Object randomDouble = $undefined,
    Object percentage = $undefined,
    Object price = $undefined,
    Object appVersion = $undefined,
    Object? deletedAt = $undefined,
    Object author = $undefined,
    Object systemAuthor = $undefined,
    Object adminAuthor = $undefined,
  }) {
    final f = faker ?? Faker();

    return CompleteModel(
      randomString:
          identical(randomString, $undefined)
              ? f.nextString()
              : randomString as String,
      prefixedString:
          identical(prefixedString, $undefined)
              ? f.nextString(prefix: 'user_')
              : prefixedString as String,
      uuid: identical(uuid, $undefined) ? f.nextUuid() : uuid as String,
      createdAt:
          identical(createdAt, $undefined)
              ? f.nextDateTime(minYear: 2000, maxYear: 2030)
              : createdAt as DateTime,
      birthDate:
          identical(birthDate, $undefined)
              ? f.nextDateTime(minYear: 1990, maxYear: 2000)
              : birthDate as DateTime,
      birthMonth:
          identical(birthMonth, $undefined)
              ? f.nextMonth()
              : birthMonth as String,
      graduationYear:
          identical(graduationYear, $undefined)
              ? f.nextYear()
              : graduationYear as String,
      meetingTime:
          identical(meetingTime, $undefined)
              ? f.nextTime()
              : meetingTime as String,
      firstName:
          identical(firstName, $undefined)
              ? f.nextFirstName()
              : firstName as String,
      lastName:
          identical(lastName, $undefined)
              ? f.nextLastName()
              : lastName as String,
      fullName:
          identical(fullName, $undefined)
              ? f.nextFullName()
              : fullName as String,
      namePrefix:
          identical(namePrefix, $undefined)
              ? f.nextPersonPrefix()
              : namePrefix as String,
      nameSuffix:
          identical(nameSuffix, $undefined)
              ? f.nextPersonSuffix()
              : nameSuffix as String,
      jobTitle:
          identical(jobTitle, $undefined)
              ? f.nextJobTitle()
              : jobTitle as String,
      email: identical(email, $undefined) ? f.nextEmail() : email as String,
      freeEmail:
          identical(freeEmail, $undefined)
              ? f.nextFreeEmail()
              : freeEmail as String,
      safeEmail:
          identical(safeEmail, $undefined)
              ? f.nextSafeEmail()
              : safeEmail as String,
      disposableEmail:
          identical(disposableEmail, $undefined)
              ? f.nextDisposableEmail()
              : disposableEmail as String,
      username:
          identical(username, $undefined)
              ? f.nextUsername()
              : username as String,
      domainName:
          identical(domainName, $undefined)
              ? f.nextDomainName()
              : domainName as String,
      domainWord:
          identical(domainWord, $undefined)
              ? f.nextDomainWord()
              : domainWord as String,
      url: identical(url, $undefined) ? f.nextUrl() : url as String,
      httpUrl:
          identical(httpUrl, $undefined) ? f.nextHttpUrl() : httpUrl as String,
      httpsUrl:
          identical(httpsUrl, $undefined)
              ? f.nextHttpsUrl()
              : httpsUrl as String,
      ipv4: identical(ipv4, $undefined) ? f.nextIpv4Address() : ipv4 as String,
      ipv6: identical(ipv6, $undefined) ? f.nextIpv6Address() : ipv6 as String,
      macAddress:
          identical(macAddress, $undefined)
              ? f.nextMacAddress()
              : macAddress as String,
      password:
          identical(password, $undefined)
              ? f.nextPassword(length: 10)
              : password as String,
      longPassword:
          identical(longPassword, $undefined)
              ? f.nextPassword(length: 20)
              : longPassword as String,
      userAgent:
          identical(userAgent, $undefined)
              ? f.nextUserAgent()
              : userAgent as String,
      zipCode:
          identical(zipCode, $undefined) ? f.nextZipCode() : zipCode as String,
      city: identical(city, $undefined) ? f.nextCity() : city as String,
      cityPrefix:
          identical(cityPrefix, $undefined)
              ? f.nextCityPrefix()
              : cityPrefix as String,
      citySuffix:
          identical(citySuffix, $undefined)
              ? f.nextCitySuffix()
              : citySuffix as String,
      streetName:
          identical(streetName, $undefined)
              ? f.nextStreetName()
              : streetName as String,
      streetAddress:
          identical(streetAddress, $undefined)
              ? f.nextStreetAddress()
              : streetAddress as String,
      streetSuffix:
          identical(streetSuffix, $undefined)
              ? f.nextStreetSuffix()
              : streetSuffix as String,
      buildingNumber:
          identical(buildingNumber, $undefined)
              ? f.nextBuildingNumber()
              : buildingNumber as String,
      neighborhood:
          identical(neighborhood, $undefined)
              ? f.nextNeighborhood()
              : neighborhood as String,
      state: identical(state, $undefined) ? f.nextState() : state as String,
      stateAbbr:
          identical(stateAbbr, $undefined)
              ? f.nextStateAbbreviation()
              : stateAbbr as String,
      country:
          identical(country, $undefined) ? f.nextCountry() : country as String,
      countryCode:
          identical(countryCode, $undefined)
              ? f.nextCountryCode()
              : countryCode as String,
      continent:
          identical(continent, $undefined)
              ? f.nextContinent()
              : continent as String,
      companyName:
          identical(companyName, $undefined)
              ? f.nextCompanyName()
              : companyName as String,
      companyPosition:
          identical(companyPosition, $undefined)
              ? f.nextCompanyPosition()
              : companyPosition as String,
      companySuffix:
          identical(companySuffix, $undefined)
              ? f.nextCompanySuffix()
              : companySuffix as String,
      word: identical(word, $undefined) ? f.nextWord() : word as String,
      words:
          identical(words, $undefined)
              ? f.nextWords(count: 3)
              : words as List<String>,
      fiveWords:
          identical(fiveWords, $undefined)
              ? f.nextWords(count: 5)
              : fiveWords as List<String>,
      sentence:
          identical(sentence, $undefined)
              ? f.nextSentence()
              : sentence as String,
      sentences:
          identical(sentences, $undefined)
              ? f.nextSentences(count: 3)
              : sentences as List<String>,
      fiveSentences:
          identical(fiveSentences, $undefined)
              ? f.nextSentences(count: 5)
              : fiveSentences as List<String>,
      paragraph:
          identical(paragraph, $undefined)
              ? f.nextParagraph()
              : paragraph as String,
      phoneNumber:
          identical(phoneNumber, $undefined)
              ? f.nextPhoneNumber()
              : phoneNumber as String,
      currencyCode:
          identical(currencyCode, $undefined)
              ? f.nextCurrencyCode()
              : currencyCode as String,
      currencyName:
          identical(currencyName, $undefined)
              ? f.nextCurrencyName()
              : currencyName as String,
      color: identical(color, $undefined) ? f.nextColor() : color as String,
      commonColor:
          identical(commonColor, $undefined)
              ? f.nextCommonColor()
              : commonColor as String,
      rgbColor:
          identical(rgbColor, $undefined)
              ? f.nextRgbColor()
              : rgbColor as String,
      restaurant:
          identical(restaurant, $undefined)
              ? f.nextRestaurant()
              : restaurant as String,
      dish: identical(dish, $undefined) ? f.nextDish() : dish as String,
      cuisine:
          identical(cuisine, $undefined) ? f.nextCuisine() : cuisine as String,
      sport: identical(sport, $undefined) ? f.nextSport() : sport as String,
      animal: identical(animal, $undefined) ? f.nextAnimal() : animal as String,
      vehicleMake:
          identical(vehicleMake, $undefined)
              ? f.nextVehicleMake()
              : vehicleMake as String,
      vehicleModel:
          identical(vehicleModel, $undefined)
              ? f.nextVehicleModel()
              : vehicleModel as String,
      vehicleYear:
          identical(vehicleYear, $undefined)
              ? f.nextVehicleYear()
              : vehicleYear as String,
      vehicleYearMakeModel:
          identical(vehicleYearMakeModel, $undefined)
              ? f.nextVehicleYearMakeModel()
              : vehicleYearMakeModel as String,
      vehicleVin:
          identical(vehicleVin, $undefined)
              ? f.nextVehicleVin()
              : vehicleVin as String,
      conference:
          identical(conference, $undefined)
              ? f.nextConference()
              : conference as String,
      latitude:
          identical(latitude, $undefined)
              ? f.nextLatitude()
              : (latitude as num).toDouble(),
      longitude:
          identical(longitude, $undefined)
              ? f.nextLongitude()
              : (longitude as num).toDouble(),
      jwtValid:
          identical(jwtValid, $undefined)
              ? f.nextJwtValid()
              : jwtValid as String,
      jwtExpired:
          identical(jwtExpired, $undefined)
              ? f.nextJwtExpired()
              : jwtExpired as String,
      imageUrl:
          identical(imageUrl, $undefined)
              ? f.nextImageUrl(width: 640, height: 480)
              : imageUrl as String,
      thumbnailUrl:
          identical(thumbnailUrl, $undefined)
              ? f.nextImageUrl(width: 100, height: 100)
              : thumbnailUrl as String,
      randomInt:
          identical(randomInt, $undefined) ? f.nextInt() : randomInt as int,
      boundedInt:
          identical(boundedInt, $undefined)
              ? f.nextInt(min: 1, max: 100)
              : boundedInt as int,
      minOnlyInt:
          identical(minOnlyInt, $undefined)
              ? f.nextInt(min: 18)
              : minOnlyInt as int,
      maxOnlyInt:
          identical(maxOnlyInt, $undefined)
              ? f.nextInt(max: 10)
              : maxOnlyInt as int,
      randomDouble:
          identical(randomDouble, $undefined)
              ? f.nextDouble()
              : (randomDouble as num).toDouble(),
      percentage:
          identical(percentage, $undefined)
              ? f.nextDouble(min: 0.0, max: 1.0)
              : (percentage as num).toDouble(),
      price:
          identical(price, $undefined)
              ? f.nextDouble(min: 9.99, max: 999.99)
              : (price as num).toDouble(),
      appVersion:
          identical(appVersion, $undefined) ? 'v1.0.0' : appVersion as String,
      deletedAt: identical(deletedAt, $undefined) ? null : deletedAt as String?,
      author: identical(author, $undefined) ? fakeAuthor(f) : author as Author,
      systemAuthor:
          identical(systemAuthor, $undefined)
              ? Author(name: 'System', email: 'system@example.com')
              : systemAuthor as Author,
      adminAuthor:
          identical(adminAuthor, $undefined)
              ? Author(name: 'Admin', email: 'admin@example.com')
              : adminAuthor as Author,
    );
  }

  @override
  Iterable<CompleteModel> many(int count, {Faker? faker}) {
    return Iterable.generate(count, (_) => call(faker: faker));
  }
}

/// Fake factory for [CompleteModel].
///
/// Use like a function: `fakeCompleteModel()` or `fakeCompleteModel(field: value)`
const _$FakeCompleteModel fakeCompleteModel = _$FakeCompleteModelImpl();
