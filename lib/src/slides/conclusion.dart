import 'package:flutter/material.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:slick_slides/slick_slides.dart';

final conclusionSlides = [
  Slide(
    transition: defaultTransition,
    builder: (context) => ContentSlide(
      title: const Text('Conclusion'),
      subtitle: const Text('Where to go from here?'),
      content: Bullets(
        bullets: const [
          'Serverpod: https://serverpod.dev',
          'Twitter: @ServerpodDev & @viktorlidholt',
          'Play the game: https://bacterialboom.com',
          'Full source code: https://github.com/serverpod/bacterialboom',
        ],
      ),
    ),
  ),
];
