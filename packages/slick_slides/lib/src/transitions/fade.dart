import 'package:flutter/material.dart';
import 'package:slick_slides/slick_slides.dart';

class SlickFadeTransition extends SlickTransition {
  const SlickFadeTransition({
    this.duration = const Duration(milliseconds: 300),
  });

  final Duration duration;

  @override
  PageRoute buildPageRoute(WidgetBuilder slideBuilder) {
    return _FadePageRoute(
      builder: slideBuilder,
      duration: duration,
    );
  }
}

class _FadePageRoute<T> extends PageRoute<T> {
  _FadePageRoute({
    required this.builder,
    required this.duration,
  });
  final WidgetBuilder builder;
  final Duration duration;

  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => 'barrier';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
}
