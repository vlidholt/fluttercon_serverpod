import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slick_slides/src/deck/deck_controls.dart';
import 'package:slick_slides/src/theme.dart';

typedef SlideBuilder = Widget Function(BuildContext context);

class SlideDeck extends StatefulWidget {
  const SlideDeck({
    required this.builders,
    this.theme = const SlideThemeData(),
    this.size = const Size(1920, 1080),
    super.key,
  });

  final List<SlideBuilder> builders;
  final SlideThemeData theme;
  final Size size;

  @override
  State<SlideDeck> createState() => SlideDeckState();
}

class SlideDeckState extends State<SlideDeck> {
  int _index = 0;

  final _focusNode = FocusNode();
  Timer? _controlsTimer;
  bool _controlsVisible = false;

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
    setState(() {
      _index += delta;
      if (_index >= widget.builders.length) {
        _index = widget.builders.length - 1;
      } else if (_index < 0) {
        _index = 0;
      }
    });
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
          _controlsVisible = false;
        });
      },
    );
    if (!_controlsVisible) {
      setState(() {
        _controlsVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_index >= widget.builders.length) {
      _index = widget.builders.length - 1;
    }

    var slide = widget.builders[_index](context);

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
                        child: slide,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: DeckControls(
                      visible: _controlsVisible,
                      onPrevious: () {
                        _onChangeSlide(-1);
                      },
                      onNext: () {
                        _onChangeSlide(1);
                      },
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
