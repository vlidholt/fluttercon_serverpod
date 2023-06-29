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

const _codeDistanceApproximation =
    '''double approximateDistance(Offset p1, Offset p2) {
  var xDiff = (p1.x - p2.x).abs();
  var yDiff = (p1.y - p2.y).abs();

  if (xDiff > yDiff) {
    return xDiff + (yDiff / 2);
  } else {
    return yDiff + (xDiff / 2);
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
];

final naiveCollisionView10 = NaiveCollisionView(10);
final naiveCollisionView100 = NaiveCollisionView(100);

class NaiveCollisionView extends NodeWithSize {
  final int _numberOfObjects;

  NaiveCollisionView(this._numberOfObjects) : super(const Size(1024, 768)) {
    var random = Random();

    for (int i = 0; i < _numberOfObjects; i++) {
      _positions.add(
        Offset(
          random.nextDouble() * 1024,
          random.nextDouble() * 768,
        ),
      );

      _velocities.add(
        Offset(
          random.nextDouble() * 50 - 25,
          random.nextDouble() * 50 - 25,
        ),
      );

      _radii.add(
        random.nextDouble() * 5 + 2,
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
      } else if (_positions[i].dx > 1024) {
        _positions[i] = Offset(1024, _positions[i].dy);
        _velocities[i] = Offset(-_velocities[i].dx, _velocities[i].dy);
      }
      if (_positions[i].dy < 0) {
        _positions[i] = Offset(_positions[i].dx, 0);
        _velocities[i] = Offset(_velocities[i].dx, -_velocities[i].dy);
      } else if (_positions[i].dy > 768) {
        _positions[i] = Offset(_positions[i].dx, 768);
        _velocities[i] = Offset(_velocities[i].dx, -_velocities[i].dy);
      }
    }
  }

  @override
  void paint(Canvas canvas) {
    super.paint(canvas);

    var circlePaint = Paint()..color = Colors.red;
    var linePaint = Paint()..color = Colors.white24;

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

final distanceView = DistanceView();

class DistanceView extends NodeWithSize {
  DistanceView() : super(const Size(512, 512));

  @override
  void paint(Canvas canvas) {
    super.paint(canvas);
    const radius = 200.0;

    var path = Path();

    for (var i = 0; i < 360; i++) {
      var angle = i * 2 * pi / 360;
      var x = cos(angle);
      var y = sin(angle);

      var approx = approximateDistance(Offset.zero, Offset(x, y));

      if (i == 0) {
        path.moveTo(x * radius * approx + 256, y * radius * approx + 256);
      } else {
        path.lineTo(x * radius * approx + 256, y * radius * approx + 256);
      }
    }

    path.close();

    canvas.drawPath(
      path,
      Paint()..color = Colors.red,
    );

    canvas.drawCircle(
      const Offset(256, 256),
      radius,
      Paint()..color = Colors.grey.shade900,
    );

    canvas.drawCircle(
      const Offset(256, 256),
      radius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
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
  }
}

double approximateDistance(Offset p1, Offset p2) {
  var xDiff = (p1.dx - p2.dx).abs();
  var yDiff = (p1.dy - p2.dy).abs();

  if (xDiff > yDiff) {
    return xDiff + (yDiff / 2);
  } else {
    return yDiff + (xDiff / 2);
  }
}
