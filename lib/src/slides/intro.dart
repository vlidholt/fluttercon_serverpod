import 'package:flutter/material.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:slick_slides/slick_slides.dart';

final introSlides = [
  Slide(
    builder: (context) => const TitleSlide(
      title: Text(
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
          'Optimizing data transfer',
          'Fancy drawing with noise',
        ],
      ),
    ),
  ),
];
