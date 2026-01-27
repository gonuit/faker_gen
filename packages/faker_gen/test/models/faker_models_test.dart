import 'package:faker_gen/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('TypeKind', () {
    test('has all expected values', () {
      expect(TypeKind.values, hasLength(8));
      expect(
        TypeKind.values,
        containsAll([
          TypeKind.primitive,
          TypeKind.enumType,
          TypeKind.dateTime,
          TypeKind.list,
          TypeKind.set,
          TypeKind.map,
          TypeKind.fakerClass,
          TypeKind.fakeWithFunction,
        ]),
      );
    });
  });

  group('SupportedTypes', () {
    group('isPrimitive', () {
      test('returns true for String', () {
        expect(SupportedTypes.isPrimitive('String'), isTrue);
      });

      test('returns true for int', () {
        expect(SupportedTypes.isPrimitive('int'), isTrue);
      });

      test('returns true for double', () {
        expect(SupportedTypes.isPrimitive('double'), isTrue);
      });

      test('returns true for num', () {
        expect(SupportedTypes.isPrimitive('num'), isTrue);
      });

      test('returns true for bool', () {
        expect(SupportedTypes.isPrimitive('bool'), isTrue);
      });

      test('returns false for DateTime', () {
        expect(SupportedTypes.isPrimitive('DateTime'), isFalse);
      });

      test('returns false for List', () {
        expect(SupportedTypes.isPrimitive('List'), isFalse);
      });

      test('returns false for custom types', () {
        expect(SupportedTypes.isPrimitive('MyClass'), isFalse);
      });
    });

    group('requiresFakeWith', () {
      test('returns true for Object', () {
        expect(SupportedTypes.requiresFakeWith('Object'), isTrue);
      });

      test('returns true for dynamic', () {
        expect(SupportedTypes.requiresFakeWith('dynamic'), isTrue);
      });

      test('returns false for String', () {
        expect(SupportedTypes.requiresFakeWith('String'), isFalse);
      });

      test('returns false for custom types', () {
        expect(SupportedTypes.requiresFakeWith('MyClass'), isFalse);
      });
    });
  });

  group('TypeInfo', () {
    group('primitive', () {
      test('creates correctly', () {
        final info = TypeInfo.primitive(
          displayString: 'String',
          primitiveType: 'String',
        );

        expect(info.kind, TypeKind.primitive);
        expect(info.displayString, 'String');
        expect(info.primitiveType, 'String');
        expect(info.enumElement, isNull);
        expect(info.listElementType, isNull);
        expect(info.mapKeyType, isNull);
        expect(info.mapValueType, isNull);
        expect(info.fakerClassName, isNull);
        expect(info.fakeWithFunctionName, isNull);
      });
    });

    group('dateTime', () {
      test('creates correctly', () {
        final info = TypeInfo.dateTime(displayString: 'DateTime');

        expect(info.kind, TypeKind.dateTime);
        expect(info.displayString, 'DateTime');
        expect(info.primitiveType, isNull);
      });
    });

    group('list', () {
      test('creates correctly with element type', () {
        final elementInfo = TypeInfo.primitive(
          displayString: 'int',
          primitiveType: 'int',
        );
        final info = TypeInfo.list(
          displayString: 'List<int>',
          elementType: elementInfo,
        );

        expect(info.kind, TypeKind.list);
        expect(info.displayString, 'List<int>');
        expect(info.listElementType, elementInfo);
        expect(info.mapKeyType, isNull);
        expect(info.mapValueType, isNull);
      });
    });

    group('map', () {
      test('creates correctly with key and value types', () {
        final keyInfo = TypeInfo.primitive(
          displayString: 'String',
          primitiveType: 'String',
        );
        final valueInfo = TypeInfo.primitive(
          displayString: 'int',
          primitiveType: 'int',
        );
        final info = TypeInfo.map(
          displayString: 'Map<String, int>',
          keyType: keyInfo,
          valueType: valueInfo,
        );

        expect(info.kind, TypeKind.map);
        expect(info.displayString, 'Map<String, int>');
        expect(info.mapKeyType, keyInfo);
        expect(info.mapValueType, valueInfo);
        expect(info.listElementType, isNull);
      });
    });

    group('fakerClass', () {
      test('creates correctly', () {
        final info = TypeInfo.fakerClass(
          displayString: 'User',
          className: 'User',
        );

        expect(info.kind, TypeKind.fakerClass);
        expect(info.displayString, 'User');
        expect(info.fakerClassName, 'User');
      });
    });

    group('fakeWithFunction', () {
      test('creates correctly', () {
        final info = TypeInfo.fakeWithFunction(
          displayString: 'CustomType',
          functionName: 'fakeCustomType',
        );

        expect(info.kind, TypeKind.fakeWithFunction);
        expect(info.displayString, 'CustomType');
        expect(info.fakeWithFunctionName, 'fakeCustomType');
      });
    });
  });

  group('FieldInfo', () {
    test('creates correctly', () {
      final typeInfo = TypeInfo.primitive(
        displayString: 'String',
        primitiveType: 'String',
      );
      final fieldInfo = FieldInfo(
        name: 'name',
        typeDisplayString: 'String',
        typeInfo: typeInfo,
        isNullable: false,
        isRequired: true,
        isNamed: true,
      );

      expect(fieldInfo.name, 'name');
      expect(fieldInfo.typeDisplayString, 'String');
      expect(fieldInfo.typeInfo, typeInfo);
      expect(fieldInfo.isNullable, isFalse);
      expect(fieldInfo.isRequired, isTrue);
      expect(fieldInfo.isNamed, isTrue);
    });

    test('creates correctly for nullable field', () {
      final typeInfo = TypeInfo.primitive(
        displayString: 'String?',
        primitiveType: 'String',
      );
      final fieldInfo = FieldInfo(
        name: 'bio',
        typeDisplayString: 'String?',
        typeInfo: typeInfo,
        isNullable: true,
        isRequired: false,
        isNamed: true,
      );

      expect(fieldInfo.name, 'bio');
      expect(fieldInfo.typeDisplayString, 'String?');
      expect(fieldInfo.isNullable, isTrue);
      expect(fieldInfo.isRequired, isFalse);
    });
  });
}
