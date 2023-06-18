import 'package:flutter/material.dart';
import 'package:slick_slides/slick_slides.dart';

class SlickFadeThroughColorTransition extends SlickTransition {
  const SlickFadeThroughColorTransition({
    this.duration = const Duration(milliseconds: 500),
    this.color = Colors.black,
  });

  final Duration duration;
  final Color color;

  @override
  PageRoute buildPageRoute(SlideBuilder slideBuilder) {
    return _FadeThroughColorPageRoute(
      builder: slideBuilder,
      duration: duration,
      color: color,
    );
  }
}

class _FadeThroughColorPageRoute<T> extends PageRoute<T> {
  _FadeThroughColorPageRoute({
    required this.builder,
    required this.duration,
    required this.color,
  });
  final SlideBuilder builder;
  final Duration duration;
  final Color color;

  @override
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => 'barrier';

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    var child = builder(context);
    return _FadeThroughColorTransition(
      color: color,
      animation: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
}

class _FadeThroughColorTransition extends StatefulWidget {
  const _FadeThroughColorTransition({
    required this.child,
    required this.color,
    required this.animation,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final Animation<double> animation;

  @override
  _FadeThroughColorTransitionState createState() =>
      _FadeThroughColorTransitionState();
}

class _FadeThroughColorTransitionState extends State<
    _FadeThroughColorTransition> /*with SingleTickerProviderStateMixin*/ {
  @override
  void initState() {
    super.initState();

    widget.animation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animation.value == 1.0) {
      return widget.child;
    } else if (widget.animation.value < 0.5) {
      return Container(
        color: widget.color.withOpacity(widget.animation.value * 2),
      );
    } else {
      return Opacity(
        opacity: (widget.animation.value - 0.5) * 2,
        child: widget.child,
      );
    }
  }
}
