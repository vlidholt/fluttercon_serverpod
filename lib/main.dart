import 'package:flutter/material.dart';
import 'package:slick_slides/slick_slides.dart';

void main() async {
  await SlickSlides().initialize();
  runApp(const MyApp());
}

const _defaultTransition = SlickFadeTransition(
  color: Colors.black,
);

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

const _codeSerializationExample = '''### Represents a person.
class: Person
fields:
  firstName: String
  lastName: String
  birthday: DateTime?
''';

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
                'Why Serverpod',
                'Real-time communication',
                'Optimizing data transfer',
                'Fancy drawing with noise',
              ],
            ),
          ),
        ),
        Slide(
          transition: _defaultTransition,
          builder: (context) => ContentSlide(
            title: const Text('Serverpod'),
            subtitle: const Text('The missing server for Flutter'),
            content: Bullets(
              bullets: const [
                'Serverpod is an open-source, scalable app server, written in '
                    'Dart for the Flutter community.',
                'TODO: Logging, caching, ORM',
              ],
            ),
          ),
        ),
        Slide(
          transition: _defaultTransition,
          builder: (context) => ContentSlide(
            title: const Text('Serverpod'),
            subtitle: const Text('The missing server for Flutter'),
            content: Bullets(
              bullets: const [
                'File uploads',
                'Authentication',
                'Real-time communication',
                'Task scheduling',
                'Health checks',
                'Deplyed on Google Cloud or AWS',
              ],
            ),
          ),
        ),
        Slide(
          transition: _defaultTransition,
          builder: (context) => const ContentSlide(
            title: Text('Serverpod'),
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
            title: Text('Serverpod'),
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
            title: Text('Serverpod'),
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
          transition: const SlickFadeTransition(),
          builder: (context) => const ContentSlide(
            title: Text('Code slide'),
            subtitle: Text('Serverpod is awesome!'),
            content: Align(
              alignment: Alignment.topLeft,
              child: ColoredCode(
                code: _codeClientExample,
                language: 'yaml',
                highlightedLines: [8, 9, 10, 11],
              ),
            ),
          ),
        ),
        Slide(
          builder: (context) => const ContentSlide(
            title: Text('Code slide'),
            subtitle: Text('Serverpod is awesome!'),
            content: Align(
              alignment: Alignment.topLeft,
              child: ColoredCode(
                code: _codeClientExample,
                highlightedLines: [12],
              ),
            ),
          ),
        ),
        Slide(
          transition: const SlickFadeTransition(),
          builder: (context) => ContentSlide(
            title: const Text('Slide 1 with Hero'),
            subtitle: const Text('So much fun'),
            background: Container(color: Colors.white),
            content: const Align(
              alignment: Alignment.centerLeft,
              child: Hero(
                tag: 'hero',
                child: FlutterLogo(size: 200),
              ),
            ),
          ),
        ),
        Slide(
          transition: const SlickFadeTransition(
            duration: Duration(seconds: 1),
          ),
          builder: (context) => ContentSlide(
            title: const Text('Slide 2 with Hero'),
            subtitle: const Text('but is it really?'),
            background: Container(color: Colors.black),
            content: const Align(
              alignment: Alignment.centerRight,
              child: Hero(
                tag: 'hero',
                child: FlutterLogo(size: 400),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
