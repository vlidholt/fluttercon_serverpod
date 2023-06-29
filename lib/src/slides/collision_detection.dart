import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercon_serverpod/src/quadtree/quadtree.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:slick_slides/slick_slides.dart';
import 'package:spritewidget/spritewidget.dart';

const _chapterTitle = 'Collision detection';

const _codePeopleEndpointExample = '''class PeopleEndpoint {
  Future<List<Person>> getPerson(Session session, String lastName) async {
    return Person.find(
      where: (t) => t.lastName.equals(lastName),
    );
  }

  Future<void> addPerson(Session session, Person person) async {
    await Person.insert(session, person);
  }
}''';

const _codePeopleEndpointWithClientExample = '''class PeopleEndpoint {
  Future<List<Person>> getPerson(Session session, String lastName) async {
    return Person.find(
      where: (t) => t.lastName.equals(lastName),
    );
  }

  Future<void> addPerson(Session session, Person person) async {
    await Person.insert(session, person);
  }
}

// Client code for getting a person.
var person = await client.people.getPerson('Doe');

// Client code for adding a person.
await client.people.addPerson(person);''';

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
    transition: crossfadeTransistion,
    builder: (context) => const ContentSlide(
      title: Text(_chapterTitle),
      subtitle: Text('Serializing objects'),
      content: Align(
        alignment: Alignment.topLeft,
        child: ColoredCode(
          code: _codePeopleEndpointWithClientExample,
          animateFromCode: _codePeopleEndpointExample,
          highlightedLines: [12, 13, 14, 15, 16, 17],
          maxAnimationDuration: Duration(seconds: 1),
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
