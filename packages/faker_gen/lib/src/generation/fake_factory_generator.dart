import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

import '../models/models.dart';

/// Naming conventions for generated fake code.
class _FakeNames {
  _FakeNames(this.originalClass);

  final String originalClass;

  String get interfaceClass => '_\$Fake$originalClass';
  String get implClass => '_\$Fake${originalClass}Impl';
  String get factoryConst => 'fake$originalClass';
}

/// Generates fake factory code using code_builder.
///
/// Produces:
/// - Abstract mixin class interface with proper types for IDE hints
/// - Implementation class with Object? parameters and sentinel checks
/// - Top-level const factory instance
///
/// Uses the shared `$undefined` sentinel from `faker_annotation` to
/// distinguish "not provided" from "explicitly null".
class FakeFactoryGenerator {
  FakeFactoryGenerator({DartFormatter? formatter})
    : _formatter =
          formatter ??
          DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);

  final DartFormatter _formatter;
  final _emitter = DartEmitter.scoped(useNullSafetySyntax: true);

  /// Generates the complete fake factory code for a class.
  String generate({
    required String className,
    required List<FieldInfo> fields,
    required FakerConfig config,
  }) {
    final names = _FakeNames(className);

    final library = Library(
      (b) =>
          b
            ..body.addAll([
              _buildFakeInterface(names, fields),
              _buildFakeImplementation(names, fields, config),
              _buildFactoryConstant(names),
            ]),
    );

    final code = library.accept(_emitter).toString();

    // Add ignore comment (no import needed - $undefined is available from
    // faker_annotation which the parent file imports for @FakeIt)
    final fullCode = '// ignore_for_file: unused_element\n\n$code';

    return _formatter.format(fullCode);
  }

  /// Builds the abstract mixin class interface with proper types for IDE hints.
  Class _buildFakeInterface(_FakeNames names, List<FieldInfo> fields) {
    return Class(
      (b) =>
          b
            ..name = names.interfaceClass
            ..abstract = true
            ..mixin = true
            ..docs.addAll([
              '/// Creates a fake instance of [${names.originalClass}] with random or provided values.',
              '///',
              '/// All parameters are optional:',
              '/// - Not provided: A random value is generated',
              '/// - Explicitly provided: The provided value is used',
              '/// - Explicitly null (for nullable fields): null is set',
              '///',
              '/// [faker] - Optional [Faker] instance for reproducible random values.',
            ])
            ..methods.addAll([
              Method((method) {
                final namedParams = fields.where((f) => f.isNamed).toList();
                final positionalParams =
                    fields.where((f) => !f.isNamed).toList();

                method
                  ..name = 'call'
                  ..returns = refer(names.originalClass)
                  ..optionalParameters.addAll([
                    Parameter(
                      (parameter) =>
                          parameter
                            ..name = 'faker'
                            ..named = true
                            ..type = _nullableType('Faker', isNullable: true),
                    ),
                    ...positionalParams.map(
                      (positionalField) => Parameter(
                        (parameter) =>
                            parameter
                              ..name = positionalField.name
                              ..named = false
                              ..type = refer(positionalField.typeDisplayString),
                      ),
                    ),
                    ...namedParams.map(
                      (namedField) => Parameter(
                        (parameter) =>
                            parameter
                              ..name = namedField.name
                              ..named = true
                              ..type = refer(namedField.typeDisplayString),
                      ),
                    ),
                  ]);
              }),
              _buildManyMethodInterface(names),
            ]),
    );
  }

  /// Builds the implementation class with Object? parameters and sentinel checks.
  Class _buildFakeImplementation(
    _FakeNames names,
    List<FieldInfo> fields,
    FakerConfig config,
  ) {
    return Class(
      (b) =>
          b
            ..name = names.implClass
            ..mixins.add(refer(names.interfaceClass))
            ..constructors.add(Constructor((c) => c..constant = true))
            ..methods.addAll([
              Method((m) {
                final namedParams = fields.where((f) => f.isNamed).toList();
                final positionalParams =
                    fields.where((f) => !f.isNamed).toList();
                m
                  ..name = 'call'
                  ..annotations.add(refer('override'))
                  ..returns = refer(names.originalClass)
                  ..optionalParameters.addAll([
                    Parameter(
                      (p) =>
                          p
                            ..name = 'faker'
                            ..named = true
                            ..type = _nullableType('Faker', isNullable: true),
                    ),
                    ...positionalParams.map(
                      (f) => Parameter(
                        (p) =>
                            p
                              ..name = f.name
                              ..named = false
                              ..type = _nullableType(
                                'Object',
                                isNullable: f.isNullable,
                              )
                              ..defaultTo = const Code(r'$undefined'),
                      ),
                    ),
                    ...namedParams.map(
                      (f) => Parameter(
                        (p) =>
                            p
                              ..name = f.name
                              ..named = true
                              ..type = _nullableType(
                                'Object',
                                isNullable: f.isNullable,
                              )
                              ..defaultTo = const Code(r'$undefined'),
                      ),
                    ),
                  ])
                  ..body = _buildCallBody(names, fields, config);
              }),
              _buildManyMethodImpl(names),
            ]),
    );
  }

  /// Builds the many() method for the interface.
  Method _buildManyMethodInterface(_FakeNames names) {
    return Method(
      (m) =>
          m
            ..name = 'many'
            ..docs.add(
              '/// Generates [count] fake instances of [${names.originalClass}].',
            )
            ..returns = TypeReference(
              (b) =>
                  b
                    ..symbol = 'Iterable'
                    ..types.add(refer(names.originalClass)),
            )
            ..requiredParameters.add(
              Parameter(
                (p) =>
                    p
                      ..name = 'count'
                      ..type = refer('int'),
              ),
            )
            ..optionalParameters.add(
              Parameter(
                (p) =>
                    p
                      ..name = 'faker'
                      ..named = true
                      ..type = _nullableType('Faker', isNullable: true),
              ),
            ),
    );
  }

  /// Builds the many() method for the implementation.
  Method _buildManyMethodImpl(_FakeNames names) {
    return Method(
      (m) =>
          m
            ..name = 'many'
            ..annotations.add(refer('override'))
            ..returns = TypeReference(
              (b) =>
                  b
                    ..symbol = 'Iterable'
                    ..types.add(refer(names.originalClass)),
            )
            ..requiredParameters.add(
              Parameter(
                (p) =>
                    p
                      ..name = 'count'
                      ..type = refer('int'),
              ),
            )
            ..optionalParameters.add(
              Parameter(
                (p) =>
                    p
                      ..name = 'faker'
                      ..named = true
                      ..type = _nullableType('Faker', isNullable: true),
              ),
            )
            ..body = Code(
              'return Iterable.generate(count, (_) => call(faker: faker));',
            ),
    );
  }

  /// Builds the call method body.
  Code _buildCallBody(
    _FakeNames names,
    List<FieldInfo> fields,
    FakerConfig config,
  ) {
    final seedArg = config.seed != null ? 'seed: ${config.seed}' : '';
    final buffer =
        StringBuffer()
          ..writeln('final f = faker ?? Faker($seedArg);')
          ..writeln()
          ..writeln('return ${names.originalClass}(');

    for (final field in fields) {
      final valueExpr = _buildValueExpression(field: field, config: config);

      if (field.isNamed) {
        buffer.writeln('  ${field.name}: $valueExpr,');
      } else {
        buffer.writeln('  $valueExpr,');
      }
    }

    buffer.writeln(');');
    return Code(buffer.toString());
  }

  /// Builds the top-level factory constant.
  Field _buildFactoryConstant(_FakeNames names) {
    return Field(
      (b) =>
          b
            ..name = names.factoryConst
            ..modifier = FieldModifier.constant
            // ..type = refer(names.interfaceClass)
            ..assignment = Code('${names.implClass}()')
            ..docs.addAll([
              '/// Fake factory for [${names.originalClass}].',
              '///',
              '/// Use like a function: `${names.factoryConst}()` or `${names.factoryConst}(field: value)`',
            ]),
    );
  }

  /// Builds the value expression for a field (sentinel check + random/cast).
  String _buildValueExpression({
    required FieldInfo field,
    required FakerConfig config,
  }) {
    final sentinelCheck = 'identical(${field.name}, \$undefined)';
    final canBeNull = config.generateNullForNullable && field.isNullable;

    // If @FakeValue is present, use the constant value
    final String randomExpr;
    if (field.hasFakeValue) {
      randomExpr = field.fakeValue ?? 'null';
    } else if (field.fakeGeneratorClass != null) {
      // If FakeGenerator<T> subclass is present, instantiate and call generate()
      final args = field.fakeGeneratorArgs;
      final generatorExpr =
          args != null && args.isNotEmpty
              ? 'const ${field.fakeGeneratorClass}($args)'
              : 'const ${field.fakeGeneratorClass}()';
      randomExpr = _wrapWithNullable(
        '$generatorExpr.generate(f)',
        canBeNull,
        config.nullProbability,
      );
    } else {
      randomExpr = _buildRandomExpression(
        field.typeInfo,
        canBeNull,
        config.nullProbability,
        fakeAsMethod: field.fakeAsMethod,
        fakeAsArgs: field.fakeAsArgs,
      );
    }

    final castExpr = _buildCastExpression(field.name, field.typeInfo);

    return '$sentinelCheck ? $randomExpr : $castExpr';
  }

  /// Wraps an expression with nullable handling if needed.
  String _wrapWithNullable(String expr, bool canBeNull, double nullProbability) {
    if (canBeNull) {
      return 'f.nextNullable(() => $expr, nullWeight: $nullProbability)';
    }
    return expr;
  }

  /// Builds the cast expression for converting Object? to the target type.
  String _buildCastExpression(String fieldName, TypeInfo typeInfo) {
    return switch (typeInfo.kind) {
      TypeKind.primitive when typeInfo.primitiveType == 'double' =>
        '($fieldName as num).toDouble()',
      _ => '$fieldName as ${typeInfo.displayString}',
    };
  }

  /// Builds the random expression for a type.
  String _buildRandomExpression(
    TypeInfo typeInfo,
    bool canBeNull,
    double nullProbability, {
    String? fakeAsMethod,
    String? fakeAsArgs,
  }) {
    // Special case: @FakeAs.alwaysNull() always returns null
    if (fakeAsMethod == r'$null') {
      return 'null';
    }

    // If @FakeAs annotation is present, use the specified method
    final baseExpr =
        fakeAsMethod != null
            ? 'f.$fakeAsMethod(${fakeAsArgs ?? ''})'
            : switch (typeInfo.kind) {
              TypeKind.primitive => _buildPrimitiveRandom(
                typeInfo.primitiveType!,
              ),
              TypeKind.enumType =>
                'f.nextEnum(${typeInfo.enumElement!.name}.values)',
              TypeKind.dateTime => 'f.nextDateTime()',
              TypeKind.list => _buildListRandom(typeInfo, nullProbability),
              TypeKind.set => _buildSetRandom(typeInfo, nullProbability),
              TypeKind.map => _buildMapRandom(typeInfo, nullProbability),
              TypeKind.fakerClass => 'fake${typeInfo.fakerClassName}(faker: f)',
              TypeKind.fakeWithFunction =>
                '${typeInfo.fakeWithFunctionName}(f)',
            };

    if (canBeNull) {
      return 'f.nextNullable(() => $baseExpr, nullWeight: $nullProbability)';
    }
    return baseExpr;
  }

  String _buildPrimitiveRandom(String type) {
    return switch (type) {
      'String' => 'f.nextString()',
      'int' => 'f.nextInt()',
      'double' => 'f.nextDouble()',
      'num' => 'f.nextNum()',
      'bool' => 'f.nextBool()',
      _ => throw StateError('Unknown primitive type: $type'),
    };
  }

  String _buildListRandom(TypeInfo typeInfo, double nullProbability) {
    final elementType = typeInfo.listElementType!;
    final isElementNullable = elementType.displayString.endsWith('?');
    final elementExpr = _buildRandomExpression(
      elementType,
      isElementNullable,
      nullProbability,
    );
    return 'f.nextListOf(() => $elementExpr)';
  }

  String _buildSetRandom(TypeInfo typeInfo, double nullProbability) {
    final elementType = typeInfo.setElementType!;
    final isElementNullable = elementType.displayString.endsWith('?');
    final elementExpr = _buildRandomExpression(
      elementType,
      isElementNullable,
      nullProbability,
    );
    return 'f.nextListOf(() => $elementExpr).toSet()';
  }

  String _buildMapRandom(TypeInfo typeInfo, double nullProbability) {
    final keyType = typeInfo.mapKeyType!;
    final valueType = typeInfo.mapValueType!;
    final isKeyNullable = keyType.displayString.endsWith('?');
    final isValueNullable = valueType.displayString.endsWith('?');
    final keyExpr = _buildRandomExpression(
      keyType,
      isKeyNullable,
      nullProbability,
    );
    final valueExpr = _buildRandomExpression(
      valueType,
      isValueNullable,
      nullProbability,
    );
    return 'Map.fromEntries(f.nextListOf(() => MapEntry($keyExpr, $valueExpr)))';
  }

  TypeReference _nullableType(String symbol, {required bool isNullable}) {
    return TypeReference(
      (b) =>
          b
            ..symbol = symbol
            ..isNullable = isNullable,
    );
  }
}
