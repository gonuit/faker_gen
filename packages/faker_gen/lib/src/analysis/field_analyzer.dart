import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:faker_annotation/faker_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../models/models.dart';
import 'type_analyzer.dart';

/// Analyzes constructor parameters and produces [FieldInfo] for code generation.
///
/// Handles:
/// - Parameter validation (named parameters required)
/// - @FakeWith annotation detection on corresponding fields
/// - @FakeAs annotation detection for String fields
/// - Type analysis delegation to [TypeAnalyzer]
class FieldAnalyzer {
  FieldAnalyzer({TypeAnalyzer? typeAnalyzer})
    : _typeAnalyzer = typeAnalyzer ?? TypeAnalyzer();

  final TypeAnalyzer _typeAnalyzer;
  static const _fakeWithChecker = TypeChecker.typeNamed(FakeWith);
  static const _fakeAsChecker = TypeChecker.typeNamed(FakeAs);

  /// Analyzes a constructor [param] and returns structured [FieldInfo].
  ///
  /// Checks for @FakeWith and @FakeAs annotations on the corresponding field in [classElement].
  /// Throws [InvalidGenerationSourceError] if parameter is invalid.
  FieldInfo analyze(FormalParameterElement param, ClassElement classElement) {
    final type = param.type;
    final isNullable = type.nullabilitySuffix == NullabilitySuffix.question;
    final isRequired = param.isRequired;
    final paramName = param.name;

    if (paramName == null || paramName.isEmpty) {
      throw InvalidGenerationSourceError(
        'All constructor parameters must have a name.',
        element: param,
      );
    }

    // Check for @FakeWith annotation on the corresponding field
    final fakeWithFunctionName = _findFakeWithFunction(paramName, classElement);

    // Check for @FakeAs annotation on the corresponding field
    final fakeAsInfo = _findFakeAsInfo(paramName, classElement, type, param);

    // Determine type info - use @FakeWith if present, else analyze type
    final TypeInfo typeInfo;
    if (fakeWithFunctionName != null) {
      typeInfo = TypeInfo.fakeWithFunction(
        displayString: type.getDisplayString(),
        functionName: fakeWithFunctionName,
      );
    } else {
      typeInfo = _typeAnalyzer.analyze(type, param);
    }

    return FieldInfo(
      name: paramName,
      typeDisplayString: type.getDisplayString(),
      typeInfo: typeInfo,
      isNullable: isNullable,
      isRequired: isRequired,
      isNamed: param.isNamed,
      fakeAsMethod: fakeAsInfo?.method,
      fakeAsArgs: fakeAsInfo?.args,
    );
  }

  /// Finds @FakeWith function name on the field matching [paramName].
  String? _findFakeWithFunction(String paramName, ClassElement classElement) {
    final field = classElement.getField(paramName);
    if (field == null) return null;

    final fakeWithAnnotation = _fakeWithChecker.firstAnnotationOf(field);
    if (fakeWithAnnotation == null) return null;

    final fakeFunctionValue = fakeWithAnnotation.getField('fakeFunction');
    if (fakeFunctionValue == null || fakeFunctionValue.isNull) return null;

    final functionElement = fakeFunctionValue.toFunctionValue();
    return functionElement?.name;
  }

  /// Finds @FakeAs info on the field matching [paramName].
  /// Returns (method, args) tuple or null if no annotation.
  /// Validates that the field type is compatible with the FakeAs return type.
  _FakeAsInfo? _findFakeAsInfo(
    String paramName,
    ClassElement classElement,
    dynamic type,
    FormalParameterElement param,
  ) {
    final field = classElement.getField(paramName);
    if (field == null) return null;

    final fakeAsAnnotation = _fakeAsChecker.firstAnnotationOf(field);
    if (fakeAsAnnotation == null) return null;

    final methodValue = fakeAsAnnotation.getField('method');
    if (methodValue == null || methodValue.isNull) return null;

    final returnTypeValue = fakeAsAnnotation.getField('returnType');
    if (returnTypeValue == null || returnTypeValue.isNull) return null;

    final method = methodValue.toStringValue()!;
    final expectedReturnType = returnTypeValue.toStringValue()!;

    // Get optional args
    final argsValue = fakeAsAnnotation.getField('args');
    final args = argsValue?.isNull == false ? argsValue?.toStringValue() : null;

    // Validate that the field type is compatible with FakeAs return type
    final typeStr = type.getDisplayString();
    final baseType = typeStr.replaceAll('?', ''); // Remove nullable suffix

    if (!_isTypeCompatible(baseType, expectedReturnType)) {
      throw InvalidGenerationSourceError(
        '@FakeAs.$method returns $expectedReturnType, but "$paramName" is $typeStr.',
        element: param,
      );
    }

    return _FakeAsInfo(method: method, args: args);
  }

  /// Checks if [fieldType] can accept a value of [fakeAsReturnType].
  bool _isTypeCompatible(String fieldType, String fakeAsReturnType) {
    // Exact match
    if (fieldType == fakeAsReturnType) return true;

    // Universal supertypes accept anything
    if (fieldType == 'dynamic' || fieldType == 'Object') return true;

    // num accepts int and double
    if (fieldType == 'num' &&
        (fakeAsReturnType == 'int' || fakeAsReturnType == 'double')) {
      return true;
    }

    return false;
  }
}

/// Internal class to hold FakeAs info.
class _FakeAsInfo {
  const _FakeAsInfo({required this.method, this.args});
  final String method;
  final String? args;
}
