import 'package:flutter/material.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:slick_slides/slick_slides.dart';

const _chapterTitle = 'Real-time communication';
const _connectionLifecycle = 'Server-side lifecycle';
const _clientConnections = 'Connecting from client';

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

const _codeStreamOpened = '''
Future<void> streamOpened(StreamingSession session) async {
  sendStreamMessage(session, myFullState);
}''';

const _codeStreamOpenedFull = '''
Future<void> streamOpened(StreamingSession session) async {
  sendStreamMessage(session, myFullState);

  session.messages.addListener('myChannel', (message) {
    sendStreamMessage(session, message);
  });
}''';

const _codeHandleStreamMessage = '''
Future<void> streamOpened(StreamingSession session) async {
  sendStreamMessage(session, myFullState);

  session.messages.addListener('myChannel', (message) {
    sendStreamMessage(session, message);
  });
}

Future<void> handleStreamMessage(
  StreamingSession session,
  SerializableEntity message,
) async {
  if (message is IncrementalStateUpdate) {
    session.messages.send('myChannel', message);
  }
}''';

const _codeClientConnection = '''
Future<void> listenToUpdates() async {
  await for (var message in client.example.stream) {
    if (update is FullStateUpdate) {
      // Handle full state update.
    }
    else if (update is IncrementalStateUpdate) {
      // Handle incremental update.
    }
  }
}''';

const _codeClientConnectionSend = '''
Future<void> listenToUpdates() async {
  await for (var message in client.example.stream) {
    if (update is FullStateUpdate) {
      // Handle full state update.
    }
    else if (update is IncrementalStateUpdate) {
      // Handle incremental update.
    }
  }
}

void sendMessage(IncrementalStateUpdate message) async {
  await client.example.sendStreamMessage(message);
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
      title: Text(_chapterTitle),
      subtitle: Text(_connectionLifecycle),
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
      title: Text(_chapterTitle),
      subtitle: Text(_connectionLifecycle),
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
      title: Text(_chapterTitle),
      subtitle: Text(_connectionLifecycle),
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
      title: Text(_chapterTitle),
      subtitle: Text(_connectionLifecycle),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeBasicStructure,
          highlightedLines: [12, 13, 14],
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_connectionLifecycle),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeStreamOpened,
        ),
      ),
    ),
  ),
  Slide(
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_connectionLifecycle),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeStreamOpenedFull,
          animateFromCode: _codeStreamOpened,
        ),
      ),
    ),
  ),
  Slide(
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_connectionLifecycle),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeHandleStreamMessage,
          animateFromCode: _codeStreamOpenedFull,
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_clientConnections),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeClientConnection,
          highlightedLines: [1, 2, 3, 4, 5, 6, 7, 8],
          animateHighlightedLines: true,
        ),
      ),
    ),
  ),
  Slide(
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_clientConnections),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeClientConnectionSend,
          animateFromCode: _codeClientConnection,
          highlightedLines: [12],
          animateHighlightedLines: true,
        ),
      ),
    ),
  ),
];
