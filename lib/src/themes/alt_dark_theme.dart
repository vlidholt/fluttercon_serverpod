import 'package:flutter/material.dart';
import 'package:slick_slides/slick_slides.dart';

var slideThemeDarkAlt = const SlideThemeData.dark(
  textTheme: SlideTextThemeData.dark(
    titleGradient: null,
    title: TextStyle(
      fontFamily: 'Inter',
      color: Colors.white,
      fontSize: 90.0,
      fontWeight: FontWeight.w900,
      height: 1.1,
      shadows: [
        BoxShadow(
          color: Colors.black87,
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        )
      ],
    ),
  ),
);
