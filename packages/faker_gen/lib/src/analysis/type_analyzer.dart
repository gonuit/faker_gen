import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:faker_annotation/faker_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../models/models.dart';

/// Analyzes Dart types and produces [TypeInfo] for code generation.
///
/// Uses a strategy pattern internally to handle different type categories.
/// Validates that types are supported and throws helpful errors if not.
class TypeAnalyzer {
  static const _fakeItChecker = TypeChecker.typeNamed(FakeIt);

  /// Analyzes [type] and returns structured [TypeInfo].
  ///
  /// Throws [InvalidGenerationSourceError] if the type is not supported
  /// or requires @FakeWith annotation.
  TypeInfo analyze(DartType type, Element contextElement) {
    final typeStr = type.getDisplayString();
    final typeStrWithoutNullability = _removeNullability(typeStr);

    // Check for dynamic or Object types (require @FakeWith)
    if (type is DynamicType ||
        SupportedTypes.requiresFakeWith(typeStrWithoutNullability)) {
      throw InvalidGenerationSourceError(
        'Field has dynamic/Object type which requires @FakeWith annotation. '
        'Add @FakeWith(yourFakeFunction) to the field, where yourFakeFunction '
        'is a top-level function with signature: `T yourFakeFunction(Faker f)`.',
        element: contextElement,
      );
    }

    // Check for primitive types
    if (SupportedTypes.isPrimitive(typeStrWithoutNullability)) {
      return TypeInfo.primitive(
        displayString: typeStr,
        primitiveType: typeStrWithoutNullability,
      );
    }

    // Check for enum types
    if (type is InterfaceType && type.element is EnumElement) {
      return TypeInfo.enumType(
        displayString: typeStr,
        enumElement: type.element as EnumElement,
      );
    }

    // Check for DateTime
    if (typeStrWithoutNullability == SupportedTypes.dateTime) {
      return TypeInfo.dateTime(displayString: typeStr);
    }

    // Check for List types
    if (type is InterfaceType && type.isDartCoreList) {
      final elementType = type.typeArguments.first;
      final elementTypeInfo = analyze(elementType, contextElement);
      return TypeInfo.list(
        displayString: typeStr,
        elementType: elementTypeInfo,
      );
    }

    // Check for Set types
    if (type is InterfaceType && type.isDartCoreSet) {
      final elementType = type.typeArguments.first;
      final elementTypeInfo = analyze(elementType, contextElement);
      return TypeInfo.set(displayString: typeStr, elementType: elementTypeInfo);
    }

    // Check for Map types
    if (type is InterfaceType && type.isDartCoreMap) {
      final keyType = type.typeArguments[0];
      final valueType = type.typeArguments[1];
      return TypeInfo.map(
        displayString: typeStr,
        keyType: analyze(keyType, contextElement),
        valueType: analyze(valueType, contextElement),
      );
    }

    // Check for class types - must have @FakeIt annotation
    if (type is InterfaceType && type.element is ClassElement) {
      final typeClassElement = type.element;
      if (!_fakeItChecker.hasAnnotationOf(typeClassElement)) {
        throw InvalidGenerationSourceError(
          'Field references type "${typeClassElement.name}" which is not '
          'annotated with @FakeIt(). All nested complex types must be '
          'annotated with @FakeIt() for fake generation to work.',
          element: contextElement,
        );
      }
      return TypeInfo.fakerClass(
        displayString: typeStr,
        className: typeClassElement.name!,
      );
    }

    // Unknown type - fail with helpful message
    throw InvalidGenerationSourceError(
      'Unsupported type: $typeStr. Only primitives, enums, DateTime, List, '
      'Map, and @FakeIt-annotated classes are supported.',
      element: contextElement,
    );
  }

  String _removeNullability(String type) {
    return type.endsWith('?') ? type.substring(0, type.length - 1) : type;
  }
}
