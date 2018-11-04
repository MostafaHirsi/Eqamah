
import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';


class CommentGenerator extends Generator {
  final bool forClasses, forLibrary;

  const CommentGenerator({this.forClasses = true, this.forLibrary = false});

  @override
  Future<String> generate(LibraryReader library, _) async {
    var output = <String>[];
    if (forLibrary) {
      var name = library.element.name;
      if (name.isEmpty) {
        name = library.element.source.uri.pathSegments.last;
      }
      output.add('// Code for "$name"');
    }
    if (forClasses) {
      for (var classElement
          in library.allElements.where((e) => e is ClassElement)) {
        if (classElement.displayName.contains('GoodError')) {
          throw InvalidGenerationSourceError(
              "Don't use classes with the word 'Error' in the name",
              todo: 'Rename ${classElement.displayName} to something else.',
              element: classElement);
        }
        output.add('// Code for "$classElement"');
      }
    }
    return output.join('\n');
  }
}