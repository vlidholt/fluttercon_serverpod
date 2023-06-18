import 'package:flutter/material.dart';

class SlideThemeData {
  const SlideThemeData({
    this.borderPadding = const EdgeInsets.symmetric(
      horizontal: 100.0,
      vertical: 60.0,
    ),
    this.titleSpacing = 20.0,
    this.subtitleSpacing = 0.0,
    this.textTheme = const SlideTextThemeData(),
  });

  final EdgeInsets borderPadding;
  final double subtitleSpacing;
  final double titleSpacing;
  final SlideTextThemeData textTheme;
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
      fontFamily: 'Open Sans',
      fontSize: 45.0,
      fontWeight: FontWeight.w500,
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
