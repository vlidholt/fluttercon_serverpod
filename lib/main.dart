import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttercon_serverpod/src/widgets/image_with_title.dart';
import 'package:fluttercon_serverpod/src/widgets/image_with_title_small.dart';
import 'package:slick_slides/slick_slides.dart';

void main() async {
  await SlickSlides().initialize();
  runApp(const MyApp());
}

const _defaultTransition = SlickFadeTransition(
  color: Colors.black,
);

const _crossfadeTransistion = SlickFadeTransition();

const _codeServerExample = '''// Endpoint on the server
class ExampleEndpoint extends Endpoint {
  Future<String> hello(Session session, String name) async {
    return 'Hello \$name';
  }
}''';

const _codeClientExample = '''// Endpoint on the server
class ExampleEndpoint extends Endpoint {
  Future<String> hello(Session session, String name) async {
    return 'Hello \$name';
  }
}

// Client code
var client = Client('https://api.example.com');
var result = await client.example.hello('World');
''';

const _codeSerializationExample = '''class: Person
fields:
  firstName: String
  lastName: String
  birthday: DateTime?
  belongings: List<Belonging>
''';

const _codeSerializationWithTableExample = '''class: Person
table: person
fields:
  firstName: String
  lastName: String
  birthday: DateTime?
  belongings: List<Belonging>
''';

const _codeSerializationWithTableAndDocsExample = '''### Represents a person.
class: Person
table: person
fields:
  ### The first name of the person.
  firstName: String

  ### The last name of the person.
  lastName: String

  ### Optional birthday.
  birthday: DateTime?

  ### The belongings of the person.
  belongings: List<Belonging>
''';

const _codeSerializationDartExample = '''// Create a Person object in Dart
var person = Person(
  firstName: 'John',
  lastName: 'Doe',
  belongings: [
    Belonging(
      name: 'Phone',
      value: 1000,
    ),
    Belonging(
      name: 'Computer',
      value: 2000,
    ),
  ],
);''';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Presentation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark,
        ),
        visualDensity: VisualDensity.compact,
        useMaterial3: true,
      ),
      home: const Scaffold(body: MyHomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SlideDeck(
      slides: [
        Slide(
          builder: (context) => const TitleSlide(
            title: Text(
              'Building a multi-player game with Flutter & Serverpod',
            ),
          ),
        ),
        Slide(
          transition: _defaultTransition,
          builder: (context) => PersonSlide(
            name: const Text('Viktor Lidholt'),
            title: const Text('Founder of Serverpod'),
            image: Image.asset('assets/portrait.png'),
          ),
          onPrecache: (context) {
            precacheImage(const AssetImage('assets/portrait.png'), context);
          },
        ),
        Slide(
          builder: (context) => const VideoSlide(
            asset: 'assets/gameplay.mov',
          ),
        ),
        Slide(
          transition: _defaultTransition,
          builder: (context) => ContentSlide(
            title: const Text('Overview'),
            subtitle: const Text('What will we learn today?'),
            content: Bullets(
              bullets: const [
                'Serverpod basics',
                'Real-time communication',
                'Optimizing data transfer',
                'Fancy drawing with noise',
              ],
            ),
          ),
        ),
        Slide(
          transition: _defaultTransition,
          theme: const SlideThemeData.light(),
          builder: (context) => const TitleSlide(
            title: Text(
              'Serverpod basics',
            ),
          ),
        ),
        Slide(
          transition: _defaultTransition,
          theme: const SlideThemeData.light(),
          builder: (context) => ContentSlide(
            title: const Text('Serverpod basics'),
            subtitle: const Text('The missing server for Flutter'),
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ImageWithTitle(
                    image: SvgPicture.asset(
                      'assets/main_features/logging.svg',
                      width: 400,
                    ),
                    title: const Text('Great logging'),
                    subtitle: const Text('Visual exception and log viewer'),
                  ),
                ),
                Expanded(
                  child: ImageWithTitle(
                    image: SvgPicture.asset(
                      'assets/main_features/caching.svg',
                      width: 400,
                    ),
                    title: const Text('Built-in caching'),
                    subtitle: const Text('On server or\nwith Redis'),
                  ),
                ),
                Expanded(
                  child: ImageWithTitle(
                    image: SvgPicture.asset(
                      'assets/main_features/orm.svg',
                      width: 400,
                    ),
                    title: const Text('Database access'),
                    subtitle:
                        const Text('Seamless integration with PostgreSQL'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Slide(
          theme: const SlideThemeData.light(),
          transition: _defaultTransition,
          builder: (context) => ContentSlide(
            title: const Text('Serverpod basics'),
            subtitle: const Text('The missing server for Flutter'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SmallImageWithTitle(
                        image: SvgPicture.asset(
                          'assets/extra_features/file_uploads.svg',
                          width: 140,
                        ),
                        title: const Text('File uploads'),
                      ),
                    ),
                    Expanded(
                      child: SmallImageWithTitle(
                        image: SvgPicture.asset(
                          'assets/extra_features/auth.svg',
                          width: 140,
                        ),
                        title: const Text('Authentication'),
                      ),
                    ),
                    Expanded(
                      child: SmallImageWithTitle(
                        image: SvgPicture.asset(
                          'assets/extra_features/streaming.svg',
                          width: 140,
                        ),
                        title: const Text('Data streaming'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 120),
                Row(
                  children: [
                    Expanded(
                      child: SmallImageWithTitle(
                        image: SvgPicture.asset(
                          'assets/extra_features/scheduling.svg',
                          width: 140,
                        ),
                        title: const Text('Task scheduling'),
                      ),
                    ),
                    Expanded(
                      child: SmallImageWithTitle(
                        image: SvgPicture.asset(
                          'assets/extra_features/health.svg',
                          width: 140,
                        ),
                        title: const Text('Health checks'),
                      ),
                    ),
                    Expanded(
                      child: SmallImageWithTitle(
                        image: SvgPicture.asset(
                          'assets/extra_features/deployment.svg',
                          width: 140,
                        ),
                        title: const Text('Easy deployment'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Slide(
          transition: _defaultTransition,
          builder: (context) => const ContentSlide(
            title: Text('Serverpod basics'),
            subtitle: Text('Calling server methods'),
            content: Align(
              alignment: Alignment.topLeft,
              child: ColoredCode(
                code: _codeServerExample,
              ),
            ),
          ),
        ),
        Slide(
          builder: (context) => const ContentSlide(
            title: Text('Serverpod basics'),
            subtitle: Text('Calling server methods'),
            content: Align(
              alignment: Alignment.topLeft,
              child: ColoredCode(
                code: _codeClientExample,
                animateFromCode: _codeServerExample,
                maxAnimationDuration: Duration(seconds: 1),
                highlightedLines: [7, 8, 9, 10, 11, 12],
                animateHighlightedLines: true,
              ),
            ),
          ),
        ),
        Slide(
          transition: _defaultTransition,
          builder: (context) => const ContentSlide(
            title: Text('Serverpod basics'),
            subtitle: Text('Serializing objects'),
            content: Align(
              alignment: Alignment.topLeft,
              child: ColoredCode(
                code: _codeSerializationExample,
                language: 'yaml',
              ),
            ),
          ),
        ),
        Slide(
          builder: (context) => const ContentSlide(
            title: Text('Serverpod basics'),
            subtitle: Text('Serializing objects'),
            content: Align(
              alignment: Alignment.topLeft,
              child: ColoredCode(
                code: _codeSerializationWithTableExample,
                animateFromCode: _codeSerializationExample,
                language: 'yaml',
              ),
            ),
          ),
        ),
        Slide(
          builder: (context) => const ContentSlide(
            title: Text('Serverpod basics'),
            subtitle: Text('Serializing objects'),
            content: Align(
              alignment: Alignment.topLeft,
              child: ColoredCode(
                code: _codeSerializationWithTableAndDocsExample,
                animateFromCode: _codeSerializationWithTableExample,
                language: 'yaml',
              ),
            ),
          ),
        ),
        Slide(
          transition: _crossfadeTransistion,
          builder: (context) => const ContentSlide(
            title: Text('Serverpod basics'),
            subtitle: Text('Serializing objects'),
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ColoredCode(
                    code: _codeSerializationWithTableAndDocsExample,
                    language: 'yaml',
                  ),
                ),
                Expanded(
                  child: ColoredCode(
                    code: _codeSerializationDartExample,
                  ),
                ),
              ],
            ),
          ),
        ),
        Slide(
          transition: _defaultTransition,
          builder: (context) => const ContentSlide(
            title: Text('Serverpod basics'),
            subtitle: Text('Serializing objects'),
            content: Align(
              alignment: Alignment.topLeft,
              child: ColoredCode(
                code: _codePeopleEndpointExample,
                highlightedLines: [1, 2, 3, 4],
                animateHighlightedLines: true,
              ),
            ),
          ),
        ),
        Slide(
          transition: _crossfadeTransistion,
          builder: (context) => const ContentSlide(
            title: Text('Serverpod basics'),
            subtitle: Text('Serializing objects'),
            content: Align(
              alignment: Alignment.topLeft,
              child: ColoredCode(
                code: _codePeopleEndpointExample,
                highlightedLines: [7, 8, 9],
              ),
            ),
          ),
        ),
        Slide(
          transition: _crossfadeTransistion,
          builder: (context) => const ContentSlide(
            title: Text('Serverpod basics'),
            subtitle: Text('Serializing objects'),
            content: Align(
              alignment: Alignment.topLeft,
              child: ColoredCode(
                code: _codePeopleEndpointWithClientExample,
                animateFromCode: _codePeopleEndpointExample,
                highlightedLines: [12, 13, 14, 15, 16, 17],
              ),
            ),
          ),
        ),
        Slide(
          transition: _defaultTransition,
          builder: (context) => const TitleSlide(
            title: Text(
              'Real-time communication',
            ),
          ),
        ),
      ],
    );
  }
}
