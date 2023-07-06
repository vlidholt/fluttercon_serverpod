import 'package:flutter/material.dart';
import 'package:fluttercon_serverpod/src/slides/shared.dart';
import 'package:slick_slides/slick_slides.dart';

final conclusionSlides = [
  Slide(
    transition: defaultTransition,
    builder: (context) => const TitleSlide(
      title: Text(
        'Where to go next?',
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => ContentSlide(
      title: const Text('Where to go next?'),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'pixorama.live',
                  style: SlideTheme.of(context)!.textTheme.subtitle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    'Multiuser drawing experience inspired by r/place.\n\nSingle page of server code.',
                    style: SlideTheme.of(context)!.textTheme.body,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Image.asset('assets/pixorama.png'),
          ),
        ],
      ),
    ),
  ),
  Slide(
    transition: defaultTransition,
    builder: (context) => ContentSlide(
      title: const Text('Where to go next?'),
      subtitle: const Text('Some great starting points'),
      content: Bullets(
        bullets: const [
          'Serverpod: https://serverpod.dev',
          'Twitter: @ServerpodDev & @viktorlidholt',
          'Play the game: https://bacterialboom.com',
          'Full source code: https://github.com/serverpod/bacterialboom',
          'Simple example: https://pixorama.live'
        ],
      ),
    ),
  ),
];
