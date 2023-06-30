import 'package:flutter/material.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:slick_slides/slick_slides.dart';

const _chapterTitle = 'Piecing it all together';

const _codeGameBoardEndpoint = '''class GameEndpoint extends Endpoint {
  final games = <GameState>[];

  GameEndpoint() {
    Timer.periodic(GameStateExtension.tickDuration, (timer) {
      for (game in games) {
        game.tick();

        var session = await serverpod.createSession();
        session.messages.postMessage(game.channel, game);
        await session.close();
      }
    });
  }

  ...
}''';

const _codeGameBoardOpenedConnection =
    '''Future<void> streamOpened(StreamingSession session) async {
  var game = GameStateExtension.findOrCreateGame();
  game.addPlayer(PlayerExtension.create(
    userId: userId,
    userInfo: userInfo.userName,
  ));

  setUserObject(session, _UserObject(
      player: player,
      game: game,
    ));

  session.messages.addListener(userObject.game.channel, (message) {
    sendStreamMessage(session, message);
  });

  sendStreamMessage(session, game);
}''';

const _codeGameBoardHandleMessage = '''Future<void> handleStreamMessage(
  StreamingSession session,
  SerializableEntity message,
) async {
  if (message is CmdPositionUpdate) {
    // Handle position update.
    var userObject = getUserObject(session) as _UserObject;
    userObject.player.blobs = message.blobs;
  } else if (message is CmdSplit) {
    // Handle a split command.
    ...
  }
}''';

const _codeGameBoardStreamClosed =
    '''Future<void> streamClosed(StreamingSession session) async {
  var userObject = getUserObject(session) as _UserObject;
  userObject.game.removePlayer(userObject.player);
}''';

const _codeOptimizeCommunication = '''# game_state.yaml
class: GameState
fields:
  gameId: int
  food: List<Food>
  players: List<Player>''';

const _codeOptimizeCommunicationUpdates = '''# game_state_update.yaml
class: GameStateUpdate
fields:
  gameId: int
  addedFood: List<Food>
  removedFood: List<int>
  players: List<Player>''';

final piecingItTogetherSlides = [
  Slide(
    transition: defaultTransition,
    builder: (context) => const TitleSlide(
      title: Text(
        _chapterTitle,
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Creating a game endpoint'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameBoardEndpoint,
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Creating a game endpoint'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameBoardEndpoint,
          highlightedLines: [4, 11],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Creating a game endpoint'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameBoardEndpoint,
          highlightedLines: [6],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Creating a game endpoint'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameBoardEndpoint,
          highlightedLines: [8, 9, 10],
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Creating a game endpoint'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameBoardOpenedConnection,
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Creating a game endpoint'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameBoardOpenedConnection,
          highlightedLines: [1, 2, 3, 4, 5],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Creating a game endpoint'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameBoardOpenedConnection,
          highlightedLines: [7, 8, 9, 10],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Creating a game endpoint'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameBoardOpenedConnection,
          highlightedLines: [12, 13, 14],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Creating a game endpoint'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameBoardOpenedConnection,
          highlightedLines: [16],
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Creating a game endpoint'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameBoardHandleMessage,
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Creating a game endpoint'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameBoardStreamClosed,
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Optimizing communication'),
      content: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ColoredCode(
                code: _codeOptimizeCommunication,
                language: 'yaml',
              ),
            ),
            Expanded(
              child: ColoredCode(
                code: _codeOptimizeCommunicationUpdates,
                language: 'yaml',
              ),
            ),
          ],
        ),
      ),
    ),
  ),
];
