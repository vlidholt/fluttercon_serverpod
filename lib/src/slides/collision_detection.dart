import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercon_serverpod/src/quadtree/quadtree.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:slick_slides/slick_slides.dart';
import 'package:spritewidget/spritewidget.dart';

const _chapterTitle = 'Collision detection';

const _codeQuadtree = '''class CollisionHandler {
  final List<Blob> blobs;

  late final Quadtree _blobsQuadtree;

  CollisionHandler({
    required this.blobs,
  }) {
    _blobsQuadTree = Quadtree(
      Rect(x: 0, y: 0, width: gameWidth, height: gameHeight),
    );
    for (var blob in blobs) {
      _blobsQuadtree.insert(BlobRect(blob));
    }
  }
}''';

const _codeQuadtreeQuery = '''List<Blob> collidesWithBlob(Body body) {
  var potentialHits = _blobsQuadtree.retrieve(body.bounds);
  var hits = <Blob>[];
  for (var potentialHit in potentialHits) {
    if (potentialHit.blob.body.collidesWith(body)) {
      hits.add(potentialHit.blob);
    }
  }
  return hits;
}''';

const _codeDistance = '''double distance(Offset p1, Offset p2) {
  var xDiff = p1.dx - p2.dx;
  var yDiff = p1.dy - p2.dy;

  return sqrt(xDiff * xDiff + yDiff * yDiff);
}''';

const _codeDistanceApproximation =
    '''double approximateDistance(Offset p1, Offset p2) {
  var xDiff = (p1.dx - p2.dx).abs();
  var yDiff = (p1.dy - p2.dy).abs();

  if (xDiff > yDiff) {
    return (xDiff + (yDiff / 2)) * 0.95;
  } else {
    return (yDiff + (xDiff / 2)) * 0.95;
  }
}''';

const _codeDistanceApproximationFast = '''int approximateDistanceFast(
  int x1,
  int y1,
  int x2,
  int y2,
) {
  var xDiff = (x1 - x2).abs();
  var yDiff = (y1 - y2).abs();

  if (xDiff > yDiff) {
    return (xDiff + (yDiff >> 1));
  } else {
    return (yDiff + (xDiff >> 1));
  }
}''';

final collisionDetectionSlides = [
  Slide(
    transition: defaultTransition,
    // theme: const SlideThemeData.light(),
    builder: (context) => const TitleSlide(
      title: Text(
        _chapterTitle,
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) {
      return ContentSlide(
        content: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: SpriteWidget(naiveCollisionView10),
        ),
      );
    },
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) {
      return ContentSlide(
        content: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: SpriteWidget(naiveCollisionView100),
        ),
      );
    },
  ),
  Slide(
    transition: const SlickFadeTransition(
      duration: Duration(milliseconds: 250),
    ),
    builder: (context) {
      return const ContentSlide(
        content: ProviderScope(
          child: FadeIn(
            child: QuadtreeView(),
          ),
        ),
      );
    },
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Quadtree'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeQuadtree,
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Quadtree'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeQuadtree,
          highlightedLines: [8, 9, 10, 11, 12, 13],
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Quadtree'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codeQuadtreeQuery,
        ),
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('A quick tip'),
      content: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ColoredCode(
                code: _codeDistance,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
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
      subtitle: Text('A quick tip'),
      content: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ColoredCode(
                code: _codeDistanceApproximation,
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => ContentSlide(
      title: const Text(_chapterTitle),
      subtitle: const Text('A quick tip'),
      content: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 2,
              child: ColoredCode(
                code: _codeDistanceApproximation,
              ),
            ),
            Expanded(
              flex: 1,
              child: SpriteWidget(
                distanceView,
                transformMode: SpriteBoxTransformMode.fixedWidth,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  Slide(
    transition: crossfadeTransistion,
    builder: (context) => ContentSlide(
      title: const Text(_chapterTitle),
      subtitle: const Text('A quick tip'),
      content: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 2,
              child: ColoredCode(
                code: _codeDistanceApproximationFast,
              ),
            ),
            Expanded(
              flex: 1,
              child: SpriteWidget(
                distanceFastView,
                transformMode: SpriteBoxTransformMode.fixedWidth,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
];

final naiveCollisionView10 = NaiveCollisionView(10);
final naiveCollisionView100 = NaiveCollisionView(100);

class NaiveCollisionView extends NodeWithSize {
  final int _numberOfObjects;

  NaiveCollisionView(this._numberOfObjects) : super(const Size(1720, 960)) {
    var random = Random();

    for (int i = 0; i < _numberOfObjects; i++) {
      _positions.add(
        Offset(
          random.nextDouble() * 1720,
          random.nextDouble() * 960,
        ),
      );

      _velocities.add(
        Offset(
          random.nextDouble() * 100 - 50,
          random.nextDouble() * 100 - 50,
        ),
      );

      _radii.add(
        random.nextDouble() * 10 + 4,
      );
    }
  }

  final List<Offset> _positions = [];
  final List<Offset> _velocities = [];
  final List<double> _radii = [];

  @override
  void update(double dt) {
    super.update(dt);

    for (var i = 0; i < _numberOfObjects; i++) {
      _positions[i] += _velocities[i] * dt;

      // Check bounds.
      if (_positions[i].dx < 0) {
        _positions[i] = Offset(0, _positions[i].dy);
        _velocities[i] = Offset(-_velocities[i].dx, _velocities[i].dy);
      } else if (_positions[i].dx > 1720) {
        _positions[i] = Offset(1720, _positions[i].dy);
        _velocities[i] = Offset(-_velocities[i].dx, _velocities[i].dy);
      }
      if (_positions[i].dy < 0) {
        _positions[i] = Offset(_positions[i].dx, 0);
        _velocities[i] = Offset(_velocities[i].dx, -_velocities[i].dy);
      } else if (_positions[i].dy > 960) {
        _positions[i] = Offset(_positions[i].dx, 960);
        _velocities[i] = Offset(_velocities[i].dx, -_velocities[i].dy);
      }
    }
  }

  @override
  void paint(Canvas canvas) {
    super.paint(canvas);

    var circlePaint = Paint()..color = Colors.red;
    var linePaint = Paint()
      ..color = Colors.white10
      ..strokeWidth = 2.0;

    for (var i = 0; i < _numberOfObjects; i++) {
      for (var j = 0; j < _numberOfObjects; j++) {
        canvas.drawLine(
          _positions[i],
          _positions[j],
          linePaint,
        );
      }
    }

    for (var i = 0; i < _numberOfObjects; i++) {
      canvas.drawCircle(
        _positions[i],
        _radii[i],
        circlePaint,
      );
    }
  }
}

final distanceView = DistanceView(false);
final distanceFastView = DistanceView(true);

class DistanceView extends NodeWithSize {
  DistanceView(this.fast) : super(const Size(512, 512));

  final bool fast;

  @override
  void paint(Canvas canvas) {
    super.paint(canvas);
    const radius = 200.0;

    var path = Path();
    var circlePath = Path();

    for (var i = 0; i < 360; i++) {
      var angle = i * 2 * pi / 360;
      var x = cos(angle);
      var y = sin(angle);

      double approx;
      if (fast) {
        approx = approximateDistanceFast(
              0,
              0,
              (x * 256).round(),
              (y * 256).round(),
            ) /
            256;
      } else {
        approx = approximateDistance(Offset.zero, Offset(x, y));
      }

      if (i == 0) {
        path.moveTo(x * radius * approx + 256, y * radius * approx + 256);
        circlePath.moveTo(x * radius + 256, y * radius + 256);
      } else {
        path.lineTo(x * radius * approx + 256, y * radius * approx + 256);
        circlePath.lineTo(x * radius + 256, y * radius + 256);
      }
    }

    path.close();
    circlePath.close();

    var diffPath = Path.combine(PathOperation.xor, path, circlePath);

    canvas.drawCircle(
      const Offset(256, 256),
      radius,
      Paint()..color = Colors.grey.shade900,
    );

    canvas.drawLine(
      const Offset(256, 0),
      const Offset(256, 512),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 2,
    );

    canvas.drawLine(
      const Offset(0, 256),
      const Offset(512, 256),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 2,
    );

    canvas.drawPath(diffPath, Paint()..color = Colors.red);

    canvas.drawCircle(
      const Offset(256, 256),
      radius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }
}

double distance(Offset p1, Offset p2) {
  var xDiff = p1.dx - p2.dx;
  var yDiff = p1.dy - p2.dy;

  return sqrt(xDiff * xDiff + yDiff * yDiff);
}

double approximateDistance(Offset p1, Offset p2) {
  var xDiff = (p1.dx - p2.dx).abs();
  var yDiff = (p1.dy - p2.dy).abs();

  if (xDiff > yDiff) {
    return (xDiff + (yDiff / 2)) * 0.95;
  } else {
    return (yDiff + (xDiff / 2)) * 0.95;
  }
}

int approximateDistanceFast(
  int x1,
  int y1,
  int x2,
  int y2,
) {
  var xDiff = (x1 - x2).abs();
  var yDiff = (y1 - y2).abs();

  if (xDiff > yDiff) {
    return (xDiff + (yDiff >> 1));
  } else {
    return (yDiff + (xDiff >> 1));
  }
}
