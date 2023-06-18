import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slick_slides/src/deck/deck_controls.dart';
import 'package:slick_slides/src/theme.dart';

typedef SlideBuilder = Widget Function(BuildContext context);

class Slide {
  const Slide({
    required this.builder,
    this.name,
  });

  final SlideBuilder builder;
  final String? name;
}

class SlideDeck extends StatefulWidget {
  const SlideDeck({
    required this.slides,
    this.theme = const SlideThemeData(),
    this.size = const Size(1920, 1080),
    super.key,
  });

  final List<Slide> slides;
  final SlideThemeData theme;
  final Size size;

  @override
  State<SlideDeck> createState() => SlideDeckState();
}

class SlideDeckState extends State<SlideDeck> {
  int _index = 0;
  final _navigatorKey = GlobalKey<NavigatorState>();

  final _focusNode = FocusNode();
  Timer? _controlsTimer;
  bool _mouseMovedRecently = false;
  bool _mouseInsideControls = false;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  void _onChangeSlide(int delta) {
    var newIndex = _index + delta;
    if (newIndex >= widget.slides.length) {
      newIndex = widget.slides.length - 1;
    } else if (newIndex < 0) {
      newIndex = 0;
    }
    if (_index != newIndex) {
      setState(() {
        _index = newIndex;
        _navigatorKey.currentState?.pushReplacementNamed(
          '$_index',
        );
      });
      _index = newIndex;
    }
  }

  void _onMouseMoved() {
    if (_controlsTimer != null) {
      _controlsTimer!.cancel();
    }
    _controlsTimer = Timer(
      const Duration(seconds: 2),
      () {
        if (!mounted) {
          return;
        }
        setState(() {
          _mouseMovedRecently = false;
        });
      },
    );
    if (!_mouseMovedRecently) {
      setState(() {
        _mouseMovedRecently = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_index >= widget.slides.length) {
      _index = widget.slides.length - 1;
    }

    return Focus(
      focusNode: _focusNode,
      onKey: (node, event) {
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.arrowRight) {
          _onChangeSlide(1);
        } else if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          _onChangeSlide(-1);
        }
        return KeyEventResult.handled;
      },
      child: MouseRegion(
        onEnter: (event) => _onMouseMoved(),
        onHover: (event) => _onMouseMoved(),
        child: Container(
          color: Colors.black,
          child: Center(
            child: AspectRatio(
              aspectRatio: widget.size.aspectRatio,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: widget.size.width,
                      height: widget.size.height,
                      child: SlideTheme(
                        data: widget.theme,
                        child: Navigator(
                          key: _navigatorKey,
                          initialRoute: '0',
                          onGenerateRoute: (settings) {
                            var index = int.tryParse(settings.name ?? '0') ?? 0;
                            var slide = widget.slides[index];
                            return MaterialPageRoute(
                              builder: (context) => slide.builder(context),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: MouseRegion(
                      onEnter: (event) {
                        setState(() {
                          _mouseInsideControls = true;
                        });
                      },
                      onExit: (event) {
                        setState(() {
                          _mouseInsideControls = false;
                        });
                      },
                      child: DeckControls(
                        visible: _mouseMovedRecently || _mouseInsideControls,
                        onPrevious: () {
                          _onChangeSlide(-1);
                        },
                        onNext: () {
                          _onChangeSlide(1);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
