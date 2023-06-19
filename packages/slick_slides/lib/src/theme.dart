import 'package:flutter/material.dart';

class SlideThemeData {
  const SlideThemeData({
    this.borderPadding = const EdgeInsets.symmetric(
      horizontal: 100.0,
      vertical: 60.0,
    ),
    this.titleSpacing = 20.0,
    this.subtitleSpacing = 0.0,
    this.horizontalSpacing = 80.0,
    this.imageBorderRadius = const BorderRadius.all(
      Radius.circular(100),
    ),
    this.imageBoxShadow = const [
      BoxShadow(
        color: Colors.black38,
        blurRadius: 40.0,
        offset: Offset(0.0, 30.0),
      ),
    ],
    this.textTheme = const SlideTextThemeData(),
    WidgetBuilder? backgroundBuilder,
  }) : _backgroundBuilder = backgroundBuilder;

  final EdgeInsets borderPadding;
  final double subtitleSpacing;
  final double titleSpacing;
  final double horizontalSpacing;
  final BorderRadiusGeometry imageBorderRadius;
  final List<BoxShadow>? imageBoxShadow;
  final SlideTextThemeData textTheme;
  final WidgetBuilder? _backgroundBuilder;

  WidgetBuilder get backgroundBuilder {
    return _backgroundBuilder ??
        (context) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade800,
                  Colors.black,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          );
        };
  }
}

class SlideTextThemeData {
  const SlideTextThemeData({
    this.title = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 90.0,
      fontWeight: FontWeight.w900,
      height: 1.1,
    ),
    this.titleGradient = const LinearGradient(
      colors: [
        Colors.orange,
        Colors.red,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.subtitle = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 55.0,
      fontWeight: FontWeight.w600,
      height: 1.1,
    ),
    this.subtitleGradient,
    this.code = const TextStyle(
      fontFamily: 'JetBrains Mono',
      fontWeight: FontWeight.normal,
      fontSize: 32.0,
    ),
    this.bullet = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 45.0,
      fontWeight: FontWeight.w400,
    ),
  });

  final TextStyle title;
  final Gradient? titleGradient;
  final TextStyle subtitle;
  final Gradient? subtitleGradient;
  final TextStyle code;
  final TextStyle bullet;
}

class SlideTheme extends InheritedWidget {
  const SlideTheme({
    required this.data,
    required super.child,
    super.key,
  });

  final SlideThemeData data;

  @override
  bool updateShouldNotify(SlideTheme oldWidget) => oldWidget.data != data;

  static SlideThemeData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SlideTheme>()?.data;
  }
}
