import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:faker_annotation/faker_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'analysis/analysis.dart';
import 'generation/generation.dart';
import 'models/models.dart';

/// Generator that creates fake factory functions for classes annotated with @FakeIt().
///
/// This is the main orchestrator that delegates to:
/// - [FieldAnalyzer] for parameter/field analysis
/// - [FakeFactoryGenerator] for code generation
class FakerGenerator extends GeneratorForAnnotation<FakeIt> {
  FakerGenerator({
    FieldAnalyzer? fieldAnalyzer,
    FakeFactoryGenerator? codeGenerator,
  }) : _fieldAnalyzer = fieldAnalyzer ?? FieldAnalyzer(),
       _codeGenerator = codeGenerator ?? FakeFactoryGenerator();

  final FieldAnalyzer _fieldAnalyzer;
  final FakeFactoryGenerator _codeGenerator;

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    _validateElement(element);
    final classElement = element as ClassElement;
    final className = classElement.name!;

    final constructor = _findConstructor(classElement);
    final fields = _analyzeFields(constructor, classElement);

    final seedValue = annotation.read('seed');
    final seed = seedValue.isNull ? null : seedValue.intValue;
    final generateNullForNullable =
        annotation.read('generateNullForNullable').boolValue;
    final nullProbability = annotation.read('nullProbability').doubleValue;

    if (nullProbability < 0.0 || nullProbability > 1.0) {
      throw InvalidGenerationSourceError(
        'nullProbability must be between 0.0 and 1.0, but got $nullProbability.',
        element: element,
      );
    }

    final config = FakerConfig(
      seed: seed,
      generateNullForNullable: generateNullForNullable,
      nullProbability: nullProbability,
    );

    return _codeGenerator.generate(
      className: className,
      fields: fields,
      config: config,
    );
  }

  void _validateElement(Element element) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@FakeIt() can only be applied to classes.',
        element: element,
      );
    }

    final className = element.name;
    if (className == null || className.isEmpty) {
      throw InvalidGenerationSourceError(
        '@FakeIt() cannot be applied to anonymous classes.',
        element: element,
      );
    }
  }

  ConstructorElement _findConstructor(ClassElement classElement) {
    // Prefer unnamed constructor
    final unnamed = classElement.unnamedConstructor;
    if (unnamed != null && !unnamed.isPrivate) {
      return unnamed;
    }

    // Fall back to first public constructor
    final publicConstructors = classElement.constructors.where(
      (c) => !c.isPrivate,
    );
    if (publicConstructors.isEmpty) {
      throw InvalidGenerationSourceError(
        'Class must have at least one public constructor.',
        element: classElement,
      );
    }

    return publicConstructors.first;
  }

  List<FieldInfo> _analyzeFields(
    ConstructorElement constructor,
    ClassElement classElement,
  ) {
    return constructor.formalParameters
        .map((param) => _fieldAnalyzer.analyze(param, classElement))
        .toList();
  }
}
