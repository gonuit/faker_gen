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
/// - @FakeValue annotation detection for constant values
/// - Type analysis delegation to [TypeAnalyzer]
class FieldAnalyzer {
  FieldAnalyzer({TypeAnalyzer? typeAnalyzer})
    : _typeAnalyzer = typeAnalyzer ?? TypeAnalyzer();

  final TypeAnalyzer _typeAnalyzer;
  static const _fakeWithChecker = TypeChecker.typeNamed(FakeWith);
  static const _fakeAsChecker = TypeChecker.typeNamed(FakeAs);
  static const _fakeValueChecker = TypeChecker.typeNamed(FakeValue);

  /// Finds a field by name in the class hierarchy (current class and all superclasses).
  FieldElement? _findFieldInHierarchy(
    String fieldName,
    ClassElement classElement,
  ) {
    // Check current class first
    var field = classElement.getField(fieldName);
    if (field != null) return field;

    // Walk up the superclass hierarchy
    var supertype = classElement.supertype;
    while (supertype != null) {
      final superElement = supertype.element;
      if (superElement is ClassElement) {
        field = superElement.getField(fieldName);
        if (field != null) return field;
        supertype = superElement.supertype;
      } else {
        break;
      }
    }

    return null;
  }

  /// Analyzes a constructor [param] and returns structured [FieldInfo].
  ///
  /// Checks for @FakeWith and @FakeAs annotations on the corresponding field in [classElement]
  /// OR on the constructor parameter itself (for super constructor parameters).
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

    // Check for @FakeWith annotation on the corresponding field or parameter
    final fakeWithFunctionName = _findFakeWithFunction(
      paramName,
      classElement,
      param,
    );

    // Check for @FakeAs annotation on the corresponding field or parameter
    final fakeAsInfo = _findFakeAsInfo(paramName, classElement, type, param);

    // Check for @FakeValue annotation on the corresponding field or parameter
    final fakeValueInfo = _findFakeValue(paramName, classElement, param);

    // Determine type info - use @FakeWith or @FakeValue if present, else analyze type
    final TypeInfo typeInfo;
    if (fakeWithFunctionName != null) {
      typeInfo = TypeInfo.fakeWithFunction(
        displayString: type.getDisplayString(),
        functionName: fakeWithFunctionName,
      );
    } else if (fakeValueInfo != null) {
      // Skip type analysis for @FakeValue - we'll use the constant value directly
      typeInfo = TypeInfo.fakeWithFunction(
        displayString: type.getDisplayString(),
        functionName: '', // Not used, but satisfies the type
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
      fakeValue: fakeValueInfo?.valueCode,
      hasFakeValue: fakeValueInfo != null,
    );
  }

  /// Finds @FakeWith function name on the field matching [paramName] (searching class hierarchy)
  /// or on the [param] itself.
  String? _findFakeWithFunction(
    String paramName,
    ClassElement classElement,
    FormalParameterElement param,
  ) {
    // First, try to find annotation on the field in class hierarchy
    final field = _findFieldInHierarchy(paramName, classElement);
    if (field != null) {
      final fakeWithAnnotation = _fakeWithChecker.firstAnnotationOf(field);
      if (fakeWithAnnotation != null) {
        final fakeFunctionValue = fakeWithAnnotation.getField('fakeFunction');
        if (fakeFunctionValue != null && !fakeFunctionValue.isNull) {
          final functionElement = fakeFunctionValue.toFunctionValue();
          if (functionElement?.name != null) {
            return functionElement!.name;
          }
        }
      }
    }

    // Fall back to checking annotation on the constructor parameter itself
    final paramAnnotation = _fakeWithChecker.firstAnnotationOf(param);
    if (paramAnnotation == null) return null;

    final fakeFunctionValue = paramAnnotation.getField('fakeFunction');
    if (fakeFunctionValue == null || fakeFunctionValue.isNull) return null;

    final functionElement = fakeFunctionValue.toFunctionValue();
    return functionElement?.name;
  }

  /// Finds @FakeAs info on the field matching [paramName] (searching class hierarchy)
  /// or on the [param] itself.
  /// Returns (method, args) tuple or null if no annotation.
  /// Validates that the field type is compatible with the FakeAs return type.
  _FakeAsInfo? _findFakeAsInfo(
    String paramName,
    ClassElement classElement,
    dynamic type,
    FormalParameterElement param,
  ) {
    // First, try to find annotation on the field in class hierarchy
    final field = _findFieldInHierarchy(paramName, classElement);
    var fakeAsAnnotation =
        field != null ? _fakeAsChecker.firstAnnotationOf(field) : null;

    // Fall back to checking annotation on the constructor parameter itself
    fakeAsAnnotation ??= _fakeAsChecker.firstAnnotationOf(param);

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
    final isNullable = typeStr.endsWith('?');

    // Special validation for @FakeAs.alwaysNull() - field must be nullable
    if (expectedReturnType == 'Null' && !isNullable) {
      throw InvalidGenerationSourceError(
        '@FakeAs.alwaysNull() can only be used on nullable fields, but "$paramName" is $typeStr.',
        element: param,
      );
    }

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

    // Null is compatible with any type (for @FakeAs.alwaysNull())
    // The nullability check is done separately in _findFakeAsInfo
    if (fakeAsReturnType == 'Null') return true;

    // num accepts int and double
    if (fieldType == 'num' &&
        (fakeAsReturnType == 'int' || fakeAsReturnType == 'double')) {
      return true;
    }

    return false;
  }

  /// Finds @FakeValue info on the field matching [paramName] (searching class hierarchy)
  /// or on the [param] itself.
  ///
  /// Uses TypeChecker to validate the annotation exists, then extracts the source code
  /// of the annotation argument. Source extraction is needed because DartObject.toString()
  /// doesn't produce valid Dart code for complex objects like `Author(name: 'x', email: 'y')`.
  _FakeValueInfo? _findFakeValue(
    String paramName,
    ClassElement classElement,
    FormalParameterElement param,
  ) {
    // First, try to find annotation on the field in class hierarchy
    final field = _findFieldInHierarchy(paramName, classElement);

    // Check if annotation exists using TypeChecker (cleaner API)
    if (field != null && _fakeValueChecker.hasAnnotationOf(field)) {
      final sourceCode = _extractFakeValueSourceCode(field.metadata.annotations);
      if (sourceCode != null) {
        return _FakeValueInfo(valueCode: sourceCode);
      }
    }

    // Fall back to checking annotation on the constructor parameter itself
    if (_fakeValueChecker.hasAnnotationOf(param)) {
      final sourceCode = _extractFakeValueSourceCode(param.metadata.annotations);
      if (sourceCode != null) {
        return _FakeValueInfo(valueCode: sourceCode);
      }
    }

    return null;
  }

  /// Extracts the source code of the FakeValue argument from element metadata.
  String? _extractFakeValueSourceCode(Iterable<ElementAnnotation> metadata) {
    for (final annotation in metadata) {
      final element = annotation.element;
      if (element is ConstructorElement) {
        final enclosingElement = element.enclosingElement;
        if (enclosingElement.name == 'FakeValue') {
          // Get the source representation of the annotation
          final source = annotation.toSource();
          // The source is like "@FakeValue(value)" - extract the argument
          // Handle both @FakeValue(value) and @FakeValue(const Constructor(...))
          final match = RegExp(r'^@FakeValue\((.+)\)$').firstMatch(source);
          if (match != null) {
            var valueSource = match.group(1)!;
            // Remove the leading 'const' if present as it's implicit in const context
            if (valueSource.startsWith('const ')) {
              valueSource = valueSource.substring(6);
            }
            return valueSource;
          }
        }
      }
    }
    return null;
  }
}

/// Internal class to hold FakeAs info.
class _FakeAsInfo {
  const _FakeAsInfo({required this.method, this.args});
  final String method;
  final String? args;
}

/// Internal class to hold FakeValue info.
class _FakeValueInfo {
  const _FakeValueInfo({required this.valueCode});
  final String valueCode;
}
