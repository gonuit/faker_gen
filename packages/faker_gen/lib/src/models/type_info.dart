import 'package:analyzer/dart/element/element.dart';

import 'type_kind.dart';

/// Holds analyzed type information for code generation.
///
/// This class captures all the details needed to generate:
/// - Random value expressions
/// - Type cast expressions
/// - Nested type handling for List/Map
final class TypeInfo {
  /// Creates a [TypeInfo] for a primitive type.
  TypeInfo.primitive({required this.displayString, required this.primitiveType})
    : kind = TypeKind.primitive,
      enumElement = null,
      listElementType = null,
      setElementType = null,
      mapKeyType = null,
      mapValueType = null,
      fakerClassName = null,
      fakeWithFunctionName = null;

  /// Creates a [TypeInfo] for an enum type.
  TypeInfo.enumType({required this.displayString, required this.enumElement})
    : kind = TypeKind.enumType,
      primitiveType = null,
      listElementType = null,
      setElementType = null,
      mapKeyType = null,
      mapValueType = null,
      fakerClassName = null,
      fakeWithFunctionName = null;

  /// Creates a [TypeInfo] for DateTime.
  TypeInfo.dateTime({required this.displayString})
    : kind = TypeKind.dateTime,
      primitiveType = null,
      enumElement = null,
      listElementType = null,
      setElementType = null,
      mapKeyType = null,
      mapValueType = null,
      fakerClassName = null,
      fakeWithFunctionName = null;

  /// Creates a [TypeInfo] for a List type.
  TypeInfo.list({required this.displayString, required TypeInfo elementType})
    : kind = TypeKind.list,
      primitiveType = null,
      enumElement = null,
      listElementType = elementType,
      setElementType = null,
      mapKeyType = null,
      mapValueType = null,
      fakerClassName = null,
      fakeWithFunctionName = null;

  /// Creates a [TypeInfo] for a Set type.
  TypeInfo.set({required this.displayString, required TypeInfo elementType})
    : kind = TypeKind.set,
      primitiveType = null,
      enumElement = null,
      listElementType = null,
      setElementType = elementType,
      mapKeyType = null,
      mapValueType = null,
      fakerClassName = null,
      fakeWithFunctionName = null;

  /// Creates a [TypeInfo] for a Map type.
  TypeInfo.map({
    required this.displayString,
    required TypeInfo keyType,
    required TypeInfo valueType,
  }) : kind = TypeKind.map,
       primitiveType = null,
       enumElement = null,
       listElementType = null,
       setElementType = null,
       mapKeyType = keyType,
       mapValueType = valueType,
       fakerClassName = null,
       fakeWithFunctionName = null;

  /// Creates a [TypeInfo] for a class annotated with @FakeIt().
  TypeInfo.fakerClass({required this.displayString, required String className})
    : kind = TypeKind.fakerClass,
      primitiveType = null,
      enumElement = null,
      listElementType = null,
      setElementType = null,
      mapKeyType = null,
      mapValueType = null,
      fakerClassName = className,
      fakeWithFunctionName = null;

  /// Creates a [TypeInfo] for a field annotated with @FakeWith().
  TypeInfo.fakeWithFunction({
    required this.displayString,
    required String functionName,
  }) : kind = TypeKind.fakeWithFunction,
       primitiveType = null,
       enumElement = null,
       listElementType = null,
       setElementType = null,
       mapKeyType = null,
       mapValueType = null,
       fakerClassName = null,
       fakeWithFunctionName = functionName;

  /// The display string of the type (e.g., "String?", "List&lt;int&gt;").
  final String displayString;

  /// The categorized kind of this type.
  final TypeKind kind;

  /// For [TypeKind.primitive]: the primitive type name.
  final String? primitiveType;

  /// For [TypeKind.enumType]: the enum element.
  final EnumElement? enumElement;

  /// For [TypeKind.list]: the element type info.
  final TypeInfo? listElementType;

  /// For [TypeKind.set]: the element type info.
  final TypeInfo? setElementType;

  /// For [TypeKind.map]: the key type info.
  final TypeInfo? mapKeyType;

  /// For [TypeKind.map]: the value type info.
  final TypeInfo? mapValueType;

  /// For [TypeKind.fakerClass]: the class name.
  final String? fakerClassName;

  /// For [TypeKind.fakeWithFunction]: the custom fake function name.
  final String? fakeWithFunctionName;
}
