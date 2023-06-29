import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercon_serverpod/src/quadtree/quadtree.dart';
import 'package:fluttercon_serverpod/src/quadtree/sidebar.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:slick_slides/slick_slides.dart';

const _chapterTitle = 'Serverpod';

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
    theme: const SlideThemeData.light(),
    builder: (context) => const TitleSlide(
      title: Text(
        'Serverpod basics',
      ),
    ),
  ),
  Slide(
    builder: (context) {
      return ProviderScope(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: Sidebar(),
            ),
            Expanded(
              child: QuadtreeView(),
            ),
          ],
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
