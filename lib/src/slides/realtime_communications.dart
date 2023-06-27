import 'package:flutter/material.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:slick_slides/slick_slides.dart';

const _codeBasicStructure = '''class ExampleEndpoint extends Endpoint {
  @override
  Future<void> streamOpened(StreamingSession session) async {
  }

  @override
  Future<void> handleStreamMessage(
    StreamingSession session,
    SerializableEntity message,
  ) async {
  }

  @override
  Future<void> streamClosed(StreamingSession session) async {
  }
}''';

final realtimeCommunicationsSlides = [
  Slide(
    transition: defaultTransition,
    builder: (context) => const TitleSlide(
      title: Text(
        'Real-time communication',
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text('Serverpod'),
      subtitle: Text('Serializing objects'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeBasicStructure,
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text('Serverpod'),
      subtitle: Text('Serializing objects'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeBasicStructure,
          highlightedLines: [1, 2, 3],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text('Serverpod'),
      subtitle: Text('Serializing objects'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeBasicStructure,
          highlightedLines: [5, 6, 7, 8, 9, 10],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text('Serverpod'),
      subtitle: Text('Serializing objects'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeBasicStructure,
          highlightedLines: [12, 13, 14],
        ),
      ),
    ),
  ),
];
