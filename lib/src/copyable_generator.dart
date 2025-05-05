import 'package:build/build.dart';
import 'package:copyable_plus/copyable.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

class CopyableGenerator extends GeneratorForAnnotation<Copyable> {
  final _primitives = {
    'int',
    'double',
    'String',
    'bool',
    'num',
    'dynamic',
    'Null',
  };

  bool _isPrimitive(DartType type) {
    final typeStr = type.getDisplayString(withNullability: false);
    return _primitives.contains(typeStr);
  }

  String _getJsonReadCode(String name, DartType type) {
    final typeStr = type.getDisplayString(withNullability: false);

    if (_isPrimitive(type)) {
      return "json['$name'] as $typeStr";
    } else if (typeStr == 'DateTime') {
      return "DateTime.parse(json['$name'])";
    } else if (typeStr.startsWith('List<')) {
      final innerType = typeStr.substring(5, typeStr.length - 1);
      final deserialize =
          _primitives.contains(innerType)
              ? 'e as $innerType'
              : '$innerType.fromJson(e)';
      return "(json['$name'] as List?)?.map((e) => $deserialize).toList() ?? []";
    } else {
      return "$typeStr.fromJson(json['$name'])";
    }
  }

  String _getJsonWriteCode(String name, DartType type) {
    final typeStr = type.getDisplayString(withNullability: false);

    if (_isPrimitive(type)) {
      return "'$name': $name";
    } else if (typeStr == 'DateTime') {
      return "'$name': $name.toIso8601String()";
    } else if (typeStr.startsWith('List<')) {
      final innerType = typeStr.substring(5, typeStr.length - 1);
      final serialize = _primitives.contains(innerType) ? 'e' : 'e.toJson()';
      return "'$name': $name.map((e) => $serialize).toList()";
    } else {
      return "'$name': $name.toJson()";
    }
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) return '';

    final className = element.name;
    final fields =
        element.fields.where((f) => !f.isStatic && !f.isPrivate).toList();

    final buffer = StringBuffer();
    buffer.writeln("part of '${element.source.uri.pathSegments.last}';");

    buffer.writeln('extension ${className}Extension on $className {');

    // copyWith
    buffer.writeln('  $className copyWith({');
    for (var field in fields) {
      buffer.writeln(
        '    ${field.type.getDisplayString(withNullability: true)}? ${field.name},',
      );
    }
    buffer.writeln('  }) {');
    buffer.writeln('    return $className(');
    for (var field in fields) {
      buffer.writeln(
        '      ${field.name}: ${field.name} ?? this.${field.name},',
      );
    }
    buffer.writeln('    );');
    buffer.writeln('  }');

    // toJson
    buffer.writeln('  Map<String, dynamic> toJson() {');
    buffer.writeln('    return {');
    for (var field in fields) {
      buffer.writeln('      ${_getJsonWriteCode(field.name, field.type)},');
    }
    buffer.writeln('    };');
    buffer.writeln('  }');

    // fromJson
    buffer.writeln('  static $className fromJson(Map<String, dynamic> json) {');
    buffer.writeln('    return $className(');
    for (var field in fields) {
      buffer.writeln(
        '      ${field.name}: ${_getJsonReadCode(field.name, field.type)},',
      );
    }
    buffer.writeln('    );');
    buffer.writeln('  }');

    buffer.writeln('}');

    return buffer.toString();
  }
}

Builder copyableGenerator(BuilderOptions options) =>
    LibraryBuilder(CopyableGenerator(), generatedExtension: '.copyable.dart');
