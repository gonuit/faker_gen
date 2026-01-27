import 'package:example/example.dart';

void main(List<String> args) {
  final count = args.isNotEmpty ? int.tryParse(args.first) ?? 1 : 1;

  for (var i = 0; i < count; i++) {
    print('\n');
    print(
      '╔═══════════════════════════════════════════════════════════════════════╗',
    );
    print(
      '                          INSTANCE ${(i + 1).toString().padLeft(3)} OF $count',
    );
    print(
      '╚═══════════════════════════════════════════════════════════════════════╝',
    );

    _printModel(fakeCompleteModel());
    if (i < count - 1) {
      print(
        '═══════════════════════════════════════════════════════════════════════',
      );
    }
  }
}

void _printModel(CompleteModel model) {
  print('\n─── String Basics ───');
  print('  randomString:      ${model.randomString}');
  print('  prefixedString:    ${model.prefixedString}');
  print('  uuid:              ${model.uuid}');

  print('\n─── DateTime ───');
  print('  createdAt:         ${model.createdAt}');
  print('  birthDate:         ${model.birthDate}');
  print('  birthMonth:        ${model.birthMonth}');
  print('  graduationYear:    ${model.graduationYear}');
  print('  meetingTime:       ${model.meetingTime}');

  print('\n─── Person ───');
  print('  firstName:         ${model.firstName}');
  print('  lastName:          ${model.lastName}');
  print('  fullName:          ${model.fullName}');
  print('  namePrefix:        ${model.namePrefix}');
  print('  nameSuffix:        ${model.nameSuffix}');

  print('\n─── Job ───');
  print('  jobTitle:          ${model.jobTitle}');

  print('\n─── Internet ───');
  print('  email:             ${model.email}');
  print('  freeEmail:         ${model.freeEmail}');
  print('  safeEmail:         ${model.safeEmail}');
  print('  disposableEmail:   ${model.disposableEmail}');
  print('  username:          ${model.username}');
  print('  domainName:        ${model.domainName}');
  print('  domainWord:        ${model.domainWord}');
  print('  url:               ${model.url}');
  print('  httpUrl:           ${model.httpUrl}');
  print('  httpsUrl:          ${model.httpsUrl}');
  print('  ipv4:              ${model.ipv4}');
  print('  ipv6:              ${model.ipv6}');
  print('  macAddress:        ${model.macAddress}');
  print('  password:          ${model.password}');
  print('  longPassword:      ${model.longPassword}');
  print('  userAgent:         ${model.userAgent}');

  print('\n─── Address ───');
  print('  zipCode:           ${model.zipCode}');
  print('  city:              ${model.city}');
  print('  cityPrefix:        ${model.cityPrefix}');
  print('  citySuffix:        ${model.citySuffix}');
  print('  streetName:        ${model.streetName}');
  print('  streetAddress:     ${model.streetAddress}');
  print('  streetSuffix:      ${model.streetSuffix}');
  print('  buildingNumber:    ${model.buildingNumber}');
  print('  neighborhood:      ${model.neighborhood}');
  print('  state:             ${model.state}');
  print('  stateAbbr:         ${model.stateAbbr}');
  print('  country:           ${model.country}');
  print('  countryCode:       ${model.countryCode}');
  print('  continent:         ${model.continent}');

  print('\n─── Company ───');
  print('  companyName:       ${model.companyName}');
  print('  companyPosition:   ${model.companyPosition}');
  print('  companySuffix:     ${model.companySuffix}');

  print('\n─── Lorem ───');
  print('  word:              ${model.word}');
  print('  words:             ${model.words}');
  print('  fiveWords:         ${model.fiveWords}');
  print('  sentence:          ${model.sentence}');
  print('  sentences:         ${model.sentences}');
  print('  fiveSentences:     ${model.fiveSentences}');
  print('  paragraph:         ${model.paragraph}');

  print('\n─── Phone ───');
  print('  phoneNumber:       ${model.phoneNumber}');

  print('\n─── Currency ───');
  print('  currencyCode:      ${model.currencyCode}');
  print('  currencyName:      ${model.currencyName}');

  print('\n─── Color ───');
  print('  color:             ${model.color}');
  print('  commonColor:       ${model.commonColor}');
  print('  rgbColor:          ${model.rgbColor}');

  print('\n─── Food ───');
  print('  restaurant:        ${model.restaurant}');
  print('  dish:              ${model.dish}');
  print('  cuisine:           ${model.cuisine}');

  print('\n─── Sport ───');
  print('  sport:             ${model.sport}');

  print('\n─── Animal ───');
  print('  animal:            ${model.animal}');

  print('\n─── Vehicle ───');
  print('  vehicleMake:       ${model.vehicleMake}');
  print('  vehicleModel:      ${model.vehicleModel}');
  print('  vehicleYear:       ${model.vehicleYear}');
  print('  vehicleYearMakeModel: ${model.vehicleYearMakeModel}');
  print('  vehicleVin:        ${model.vehicleVin}');

  print('\n─── Conference ───');
  print('  conference:        ${model.conference}');

  print('\n─── Geo ───');
  print('  latitude:          ${model.latitude}');
  print('  longitude:         ${model.longitude}');

  print('\n─── JWT ───');
  print('  jwtValid:          ${model.jwtValid}');
  print('  jwtExpired:        ${model.jwtExpired}');

  print('\n─── Image ───');
  print('  imageUrl:          ${model.imageUrl}');
  print('  thumbnailUrl:      ${model.thumbnailUrl}');

  print('\n─── Primitives ───');
  print('  randomInt:         ${model.randomInt}');
  print('  boundedInt:        ${model.boundedInt}');
  print('  minOnlyInt:        ${model.minOnlyInt}');
  print('  maxOnlyInt:        ${model.maxOnlyInt}');
  print('  randomDouble:      ${model.randomDouble}');
  print('  percentage:        ${model.percentage}');
  print('  price:             ${model.price}');
}
