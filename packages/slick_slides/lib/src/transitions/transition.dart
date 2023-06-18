import 'package:flutter/material.dart';
import 'package:slick_slides/slick_slides.dart';

abstract class SlickTransition {
  const SlickTransition();

  PageRoute buildPageRoute(SlideBuilder slideBuilder);
}
