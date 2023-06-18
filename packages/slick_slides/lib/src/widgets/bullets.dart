// import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:slick_slides/slick_slides.dart';

const _defaultBulletSpacing = 0.3;

class Bullets extends StatelessWidget {
  factory Bullets({
    required List<String> bullets,
    double bulletSpacing = _defaultBulletSpacing,
    Key? key,
  }) {
    var richBullets = bullets.map((e) => TextSpan(text: e)).toList();
    return Bullets.rich(
      bullets: richBullets,
      bulletSpacing: bulletSpacing,
      key: key,
    );
  }

  const Bullets.rich({
    required this.bullets,
    this.bulletSpacing = _defaultBulletSpacing,
    super.key,
  });

  final List<TextSpan> bullets;
  final double bulletSpacing;

  @override
  Widget build(BuildContext context) {
    var theme = SlideTheme.of(context)!;

    var joinedBulletsList = <TextSpan>[];
    for (var i = 0; i < bullets.length; i++) {
      joinedBulletsList.add(bullets[i]);

      // Add a new line between bullets.
      if (i != bullets.length - 1) {
        joinedBulletsList.addAll([
          const TextSpan(
            text: '\n',
          ),
          TextSpan(
            text: '\n',
            style: TextStyle(
              height: bulletSpacing,
            ),
          ),
        ]);
      }
    }

    var joinedBullets = TextSpan(
      children: joinedBulletsList,
    );

    return DefaultTextStyle(
      style: theme.textTheme.bullet,
      child: AutoSizeText.rich(joinedBullets),
    );
  }
}
