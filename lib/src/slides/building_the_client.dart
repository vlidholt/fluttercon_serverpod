import 'package:bacterialboom_flutter/bacterialboom.dart';
import 'package:flutter/material.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:fluttercon_serverpod/src/themes/alt_dark_theme.dart';
import 'package:fluttercon_serverpod/src/widgets/blob_view.dart';
import 'package:fluttercon_serverpod/src/widgets/blob_view_2.dart';
import 'package:fluttercon_serverpod/src/widgets/blob_view_3.dart';
import 'package:fluttercon_serverpod/src/widgets/ui_image.dart';
import 'package:slick_slides/slick_slides.dart';

const _chapterTitle = 'Building the app';
const _secondChapter = 'The answer is noise';
const _handlingStreamingConnection = 'Handling the streaming connection';
const _strategiesForUpdating = 'Strategies for updating the state';
const _drawingThePlayers = 'Drawing the players';

const _codeGamePageWidget = '''class GamePage extends StatefulWidget {
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameState? _gameState;
  late final StreamingConnectionHandler _connectionHandler;

  void initState() {
    _connectionHandler = StreamingConnectionHandler(...);
    _connectionHandler.connect();
    _listenToUpdates();
  }

  ...
}''';

const _codeListenToUpdates = '''Future<void> _listenToUpdates() async {
  await for (var update in client.gameBoard.stream) {
    if (update is GameState) {
      setState(() {
        _gameState = update;
      });
    } else if (update is GameStateUpdate) {
      setState(() {
        _gameState!.update(update);
      });
    }
  }
}''';

const _noiseCode = '''noise = OpenSimplex2S(seed);
for (int y = 0; y < height; y += 1) {
  for (int x = 0; x < width; x += 1) {
    var u = x / width * 2 * pi;
    var v = y / height * 2 * pi;
    var nx = cos(u);
    var ny = sin(u);
    var nz = cos(v);
    var nw = sin(v);

    grid[y * width + x] = fnoise.noise4Classic(
      frequency * nx,
      frequency * ny,
      frequency * nz,
      frequency * nw,
    );
  }
}''';

final _keyBackground = GlobalKey();
final _keyBlob = GlobalKey();
final _keyAnimatedGifs = GlobalKey();

final buildingTheClientSlides = [
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
      subtitle: Text(_handlingStreamingConnection),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeGamePageWidget,
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text(_handlingStreamingConnection),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeListenToUpdates,
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => ContentSlide(
      title: const Text(_chapterTitle),
      subtitle: const Text(_strategiesForUpdating),
      content: Align(
        alignment: Alignment.topLeft,
        child: Bullets(
          bullets: const [
            'Option A: Immediately update the state',
            'Option B: Animate to the new state',
            'Be smart about how you handle the current player',
          ],
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => BlobSlide(
      key: _keyBlob,
    ),
  ),
  Slide(
    transition: defaultTransition,
    theme: slideThemeDarkAlt,
    builder: (context) {
      return TitleSlide(
        background: ScrollingBackground(
          key: _keyBackground,
        ),
        title: const Text(_secondChapter),
      );
    },
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) {
      var theme = SlideTheme.of(context)!;
      return ContentSlide(
        title: const Text(_secondChapter),
        subtitle: const Text('Generate looping noise'),
        content: Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 2,
                child: ColoredCode(
                  code: _noiseCode,
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      boxShadow: theme.imageBoxShadow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: UiImage(
                      resourceManager.noiseImage,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) {
      return const BlobSlide2();
    },
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) {
      var theme = SlideTheme.of(context)!;
      return ContentSlide(
        content: Row(
          key: _keyAnimatedGifs,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: 500,
                  height: 500,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    boxShadow: theme.imageBoxShadow,
                    borderRadius: theme.imageBorderRadius,
                  ),
                  child: Image.asset('assets/noisegifs/2.webp'),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 500,
                  height: 500,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    boxShadow: theme.imageBoxShadow,
                    borderRadius: theme.imageBorderRadius,
                  ),
                  child: Image.asset('assets/noisegifs/4.webp'),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 500,
                  height: 500,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    boxShadow: theme.imageBoxShadow,
                    borderRadius: theme.imageBorderRadius,
                  ),
                  child: Image.asset('assets/noisegifs/3.webp'),
                ),
              ),
            ),
          ],
        ),
      );
    },
  ),
];

class BlobSlide extends StatefulWidget {
  const BlobSlide({super.key});

  @override
  State<BlobSlide> createState() => _BlobSlideState();
}

class _BlobSlideState extends State<BlobSlide> {
  double _radius = 5.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ContentSlide(
          title: Text(_chapterTitle),
          subtitle: Text(_drawingThePlayers),
        ),
        BlobView(
          radius: _radius,
        ),
        Positioned(
          bottom: 50.0,
          left: 50.0,
          right: 50.0,
          child: Slider(
            activeColor: Colors.blue,
            value: _radius,
            min: 5.0,
            max: 12.0,
            onChanged: (val) {
              setState(() {
                _radius = val;
              });
            },
          ),
        ),
      ],
    );
  }
}

class BlobSlide2 extends StatefulWidget {
  const BlobSlide2({super.key});

  @override
  State<BlobSlide2> createState() => _BlobSlideState2();
}

class _BlobSlideState2 extends State<BlobSlide2> {
  double _size = 5.0;
  double _offset = 256.0;
  double _amplitude = 0.0;

  @override
  Widget build(BuildContext context) {
    var theme = SlideTheme.of(context)!;

    return ContentSlide(
      title: const Text(_secondChapter),
      subtitle: const Text('Blob from noise'),
      content: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 110.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Slider(
                      value: _size,
                      min: 1.0,
                      max: 10.0,
                      onChanged: (value) {
                        setState(() {
                          _size = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Size',
                        style: theme.textTheme.body,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Slider(
                      value: _amplitude,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (value) {
                        setState(() {
                          _amplitude = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Amplitude',
                        style: theme.textTheme.body,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Slider(
                      value: _offset,
                      min: 0.0,
                      max: 512.0,
                      onChanged: (value) {
                        setState(() {
                          _offset = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Offset',
                        style: theme.textTheme.body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Transform(
                  transform: Matrix4.identity()..translate(-50.0, 0.0),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      boxShadow: theme.imageBoxShadow,
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: BlobView2(
                      radius: _size,
                      offset: _offset,
                      amplitude: _amplitude,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    boxShadow: theme.imageBoxShadow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: UiImage(
                          resourceManager.noiseImage,
                        ),
                      ),
                      BlobView3(
                        radius: _size,
                        offset: _offset,
                        amplitude: _amplitude,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
