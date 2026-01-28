import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
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
/// - FakeGenerator<T> subclass detection for custom generators
/// - Type analysis delegation to [TypeAnalyzer]
class FieldAnalyzer {
  FieldAnalyzer({TypeAnalyzer? typeAnalyzer})
    : _typeAnalyzer = typeAnalyzer ?? TypeAnalyzer();

  final TypeAnalyzer _typeAnalyzer;
  static const _fakeWithChecker = TypeChecker.typeNamed(
    FakeWith,
    inPackage: 'faker_annotation',
  );
  static const _fakeAsChecker = TypeChecker.typeNamed(
    FakeAs,
    inPackage: 'faker_annotation',
  );
  static const _fakeValueChecker = TypeChecker.typeNamed(
    FakeValue,
    inPackage: 'faker_annotation',
  );
  static const _fakeGeneratorChecker = TypeChecker.typeNamed(
    FakeGenerator,
    inPackage: 'faker_annotation',
  );

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

    // Check for FakeGenerator<T> subclass annotation on the field or parameter
    final fakeGeneratorInfo = _findFakeGenerator(paramName, classElement, param);

    // Check for @FakeAs annotation on the corresponding field or parameter
    final fakeAsInfo = _findFakeAsInfo(paramName, classElement, type, param);

    // Check for @FakeValue annotation on the corresponding field or parameter
    final fakeValueInfo = _findFakeValue(paramName, classElement, param);

    // Determine type info - use @FakeWith, FakeGenerator, @FakeValue, or @FakeAs on dynamic if present
    final TypeInfo typeInfo;
    if (fakeWithFunctionName != null) {
      typeInfo = TypeInfo.fakeWithFunction(
        displayString: type.getDisplayString(),
        functionName: fakeWithFunctionName,
      );
    } else if (fakeGeneratorInfo != null) {
      // Skip type analysis for FakeGenerator - we'll instantiate and call generate()
      typeInfo = TypeInfo.fakeWithFunction(
        displayString: type.getDisplayString(),
        functionName: '', // Not used, fakeGeneratorClass will be used instead
      );
    } else if (fakeValueInfo != null) {
      // Skip type analysis for @FakeValue - we'll use the constant value directly
      typeInfo = TypeInfo.fakeWithFunction(
        displayString: type.getDisplayString(),
        functionName: '', // Not used, but satisfies the type
      );
    } else if (fakeAsInfo != null && _isDynamicOrObject(type)) {
      // Skip type analysis for @FakeAs on dynamic/Object - we'll use the FakeAs method
      typeInfo = TypeInfo.fakeWithFunction(
        displayString: type.getDisplayString(),
        functionName: '', // Not used, fakeAsMethod will be used instead
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
      fakeGeneratorClass: fakeGeneratorInfo?.className,
      fakeGeneratorArgs: fakeGeneratorInfo?.args,
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

  /// Finds a FakeGenerator<T> subclass annotation on the field matching [paramName]
  /// (searching class hierarchy) or on the [param] itself.
  _FakeGeneratorInfo? _findFakeGenerator(
    String paramName,
    ClassElement classElement,
    FormalParameterElement param,
  ) {
    // First, try to find annotation on the field in class hierarchy
    final field = _findFieldInHierarchy(paramName, classElement);
    if (field != null) {
      final generatorInfo = _extractFakeGeneratorInfo(field.metadata.annotations);
      if (generatorInfo != null) return generatorInfo;
    }

    // Fall back to checking annotation on the constructor parameter itself
    return _extractFakeGeneratorInfo(param.metadata.annotations);
  }

  /// Extracts FakeGenerator info from element metadata.
  /// Looks for any annotation that is a subclass of FakeGenerator<T>.
  _FakeGeneratorInfo? _extractFakeGeneratorInfo(
    Iterable<ElementAnnotation> metadata,
  ) {
    for (final annotation in metadata) {
      final element = annotation.element;
      if (element is ConstructorElement) {
        final enclosingClass = element.enclosingElement;
        if (enclosingClass is ClassElement) {
          // Check if this class extends FakeGenerator
          if (_isFakeGeneratorSubclass(enclosingClass)) {
            final source = annotation.toSource();
            // Extract constructor args from @ClassName(...) or @ClassName()
            final match = RegExp(r'^@(\w+)\((.*)\)$').firstMatch(source);
            if (match != null) {
              final className = match.group(1)!;
              final args = match.group(2)!;
              return _FakeGeneratorInfo(
                className: className,
                args: args.isEmpty ? null : args,
              );
            }
            // Handle @ClassName without parentheses (const annotation)
            final simpleMatch = RegExp(r'^@(\w+)$').firstMatch(source);
            if (simpleMatch != null) {
              return _FakeGeneratorInfo(
                className: simpleMatch.group(1)!,
                args: null,
              );
            }
          }
        }
      }
    }
    return null;
  }

  /// Checks if a class is a subclass of FakeGenerator.
  bool _isFakeGeneratorSubclass(ClassElement classElement) {
    // Check if this class or any of its supertypes is FakeGenerator
    var current = classElement.supertype;
    while (current != null) {
      if (_fakeGeneratorChecker.isExactlyType(current)) {
        return true;
      }
      final element = current.element;
      if (element is ClassElement) {
        current = element.supertype;
      } else {
        break;
      }
    }
    return false;
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

  /// Checks if the type is dynamic or Object (types that need @FakeWith/@FakeAs).
  bool _isDynamicOrObject(dynamic type) {
    if (type is DynamicType) return true;
    final typeStr = type.getDisplayString();
    final baseType = typeStr.replaceAll('?', '');
    return baseType == 'dynamic' || baseType == 'Object';
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

/// Internal class to hold FakeGenerator info.
class _FakeGeneratorInfo {
  const _FakeGeneratorInfo({required this.className, this.args});
  final String className;
  final String? args;
}
