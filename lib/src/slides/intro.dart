import 'package:bacterialboom_flutter/bacterialboom.dart';
import 'package:flutter/material.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:fluttercon_serverpod/src/themes/alt_dark_theme.dart';
import 'package:fluttercon_serverpod/src/widgets/intro_blobs.dart';
import 'package:slick_slides/slick_slides.dart';

final _keyBackground = GlobalKey();

final introSlides = [
  Slide(
    theme: slideThemeDarkAlt,
    builder: (context) => TitleSlide(
      background: Stack(
        key: _keyBackground,
        children: const [
          ScrollingBackground(),
          IntroBlobsView(),
        ],
      ),
      title: const Text(
        'Building a multi-player game with Flutter & Serverpod',
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
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
    transition: defaultTransition,
    builder: (context) => ContentSlide(
      title: const Text('Overview'),
      subtitle: const Text('What will we learn today?'),
      content: Bullets(
        bullets: const [
          'Serverpod basics',
          'Real-time communication',
          '  • Server side',
          '  • Client side',
          'Building the game',
          '  • Data structures',
          '  • Game loop',
          '  • Detecting collisions',
          'Fancy drawing with noise functions',
        ],
      ),
    ),
  ),
];
