import 'package:flutter/material.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:slick_slides/slick_slides.dart';

const _chapterTitle = 'Building the game';
const _dataStructures = 'Data structures';
const _gameLoop = 'The game loop';

const _codeDataStructuresBlobFood = '''# blob.yaml
class: Blob
fields:
  blobId: int
  body: Body

# food.yaml
class: Food
fields:
  foodId: int
  body: Body''';

const _codeDataStructuresBody = '''# body.yaml
class: Body
fields:
  x: double
  y: double
  radius: double''';

const _codeDataStructuresPlayer = '''# player.yaml
class: Player
fields:
  userId: int
  name: String
  blobs: List<Blob>
  score: double''';

const _codeDataStructuresPlayerGameState = '''# player.yaml
class: Player
fields:
  userId: int
  name: String
  blobs: List<Blob>
  score: double

# game_state.yaml
class: GameState
fields:
  gameId: int
  food: List<Food>
  players: List<Player>''';

const _codeExtensionsBody = '''// body.dart
extension BodyExtension on Body {
  double get area => radius * radius * pi;

  set area(double area) {
    radius = sqrt(area / pi);
  }

  bool collidesWith(Body other) {
    var distance = approximateDistance(
      position,
      other.position,
    );
    return distance < radius + other.radius;
  }
}''';

const _codeGameLoop = '''extension GameStateExtension on GameState {
  void tick() {
    // 1. Move non playing characters.

    // 2. Check collisions with food and between player blobs.
    //    - Remove food that was eaten.
    //    - Remove blobs that were eaten.
    //    - Grow blobs that ate food or other blobs.

    // 3. Remove players with no blobs left.

    // 4. Spawn new food and NPCs.
  }
}''';

final buildingTheGameSlides = [
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
      subtitle: Text(_dataStructures),
      content: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ColoredCode(
                code: _codeDataStructuresBlobFood,
                language: 'yaml',
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_dataStructures),
      content: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ColoredCode(
                code: _codeDataStructuresBlobFood,
                language: 'yaml',
              ),
            ),
            Expanded(
              child: ColoredCode(
                code: _codeDataStructuresBody,
                language: 'yaml',
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_dataStructures),
      content: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ColoredCode(
                code: _codeDataStructuresBlobFood,
                language: 'yaml',
              ),
            ),
            Expanded(
              child: ColoredCode(
                code: _codeDataStructuresBody,
                language: 'yaml',
              ),
            ),
            Expanded(
              child: ColoredCode(
                code: _codeDataStructuresPlayer,
                language: 'yaml',
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_dataStructures),
      content: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ColoredCode(
                code: _codeDataStructuresBlobFood,
                language: 'yaml',
              ),
            ),
            Expanded(
              child: Hero(
                tag: 'code-body',
                child: ColoredCode(
                  code: _codeDataStructuresBody,
                  language: 'yaml',
                ),
              ),
            ),
            Expanded(
              child: ColoredCode(
                code: _codeDataStructuresPlayerGameState,
                language: 'yaml',
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_dataStructures),
      content: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'code-body',
                child: ColoredCode(
                  code: _codeDataStructuresBody,
                  language: 'yaml',
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ColoredCode(
                code: _codeExtensionsBody,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_gameLoop),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameLoop,
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_gameLoop),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameLoop,
          highlightedLines: [2],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_gameLoop),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameLoop,
          highlightedLines: [4, 5, 6, 7],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_gameLoop),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameLoop,
          highlightedLines: [9],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_gameLoop),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGameLoop,
          highlightedLines: [11],
        ),
      ),
    ),
  ),
];
