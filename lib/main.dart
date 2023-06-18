import 'package:flutter/material.dart';
import 'package:fluttercon_serverpod/theme.dart';
import 'package:slick_slides/slick_slides.dart';

void main() {
  runApp(const MyApp());
}

const _code = '''
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Presentation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
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
      theme: buildTheme(),
      builders: [
        (context) => TitleSlide(
              title: const Text('Whereas recognition of the inherent'),
              subtitle: const Text('Serverpod is awesome!'),
              background: Container(color: Colors.deepPurple),
            ),
        (context) => ContentSlide(
            title: const Text('Slide 2\nHello'),
            subtitle: const Text('Serverpod is awesome!\n2nd line'),
            background: Container(color: Colors.blue),
            content: Bullets(
              bullets: const [
                'Bullet 1',
                'Bullet 1',
                'Bullet 1',
                'Bullet 1b asfduououan sdopifuaopsfudpoasiufpoan sopi opasudf opasudfopau dfpoi apsodifhaskohfkoash flakjhf lkasjhf laksjf lkasj hflaksjh dlfkh alsd',
                'Bullet 1',
              ],
            )),
        (context) => ContentSlide(
              title: const Text('Third slide'),
              subtitle: const Text('Serverpod is awesome!'),
              content: const Align(
                alignment: Alignment.centerLeft,
                child: ColoredCode(
                  code: _code,
                ),
              ),
              background: Container(color: Colors.blueGrey[900]),
            ),
      ],
    );
  }
}
