import 'package:flutter/material.dart';
import 'package:slick_slides/slick_slides.dart';

void main() async {
  await SlickSlides().initialize();
  runApp(const MyApp());
}

const _codeA = '''class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
  }
}''';

const _codeB = '''// Adding a long comment on the first line
class MyApp extends StatelessWidget {
  const ServerpodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Presentation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const FantasticApp(),
    );
  }
}''';

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
      home: const MyHomePage(),
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
          builder: (context) => TitleSlide(
            title: const Text('Whereas recognition of the inherent'),
            subtitle: const Text('Serverpod is awesome'),
            background: Container(color: Colors.deepPurple),
          ),
        ),
        Slide(
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
          transition: const SlickFadeTransition(),
          theme: const SlideThemeData.light(),
          builder: (context) => ContentSlide(
            title: const Text('Slide 2\nHello'),
            subtitle: const Text('Serverpod is awesome!\n2nd line'),
            content: Bullets(
              bullets: const [
                'Bullet 1',
                'Bullet 1',
                'Bullet 1',
                'Bullet 1b asfduououan sdopifuaopsfudpoasiufpoan sopi opasudf opasudfopau dfpoi apsodifhaskohfkoash flakjhf lkasjhf laksjf lkasj hflaksjh dlfkh alsd',
                'Bullet 1',
              ],
            ),
          ),
        ),
        Slide(
          transition: const SlickFadeTransition(
            color: Colors.black,
          ),
          builder: (context) => const ContentSlide(
            title: Text('Code slide'),
            subtitle: Text('Serverpod is awesome!'),
            content: Align(
              alignment: Alignment.centerLeft,
              child: ColoredCode(
                code: _codeA,
              ),
            ),
          ),
        ),
        Slide(
          builder: (context) => const ContentSlide(
            title: Text('Code slide'),
            subtitle: Text('Serverpod is awesome!'),
            content: Align(
              alignment: Alignment.centerLeft,
              child: ColoredCode(
                animateFromCode: _codeA,
                code: _codeB,
              ),
            ),
          ),
        ),
        Slide(
          builder: (context) => const ContentSlide(
            title: Text('Code slide'),
            subtitle: Text('Serverpod is awesome!'),
            content: Align(
              alignment: Alignment.centerLeft,
              child: ColoredCode(
                code: _codeB,
                animateHighlightedLines: true,
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
              alignment: Alignment.centerLeft,
              child: ColoredCode(
                code: _codeB,
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
