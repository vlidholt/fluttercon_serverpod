import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:slick_slides/slick_slides.dart';

class ColoredCode extends StatefulWidget {
  const ColoredCode({
    required this.code,
    this.animateFromCode,
    this.language = 'dart',
    this.codeTheme = draculaTheme,
    this.textStyle,
    this.maxAnimationDuration = const Duration(milliseconds: 2000),
    this.keystrokeDuration = const Duration(milliseconds: 50),
    super.key,
  });

  final String code;
  final String? animateFromCode;
  final String language;
  final Map<String, TextStyle> codeTheme;
  final TextStyle? textStyle;
  final Duration maxAnimationDuration;
  final Duration keystrokeDuration;

  @override
  State<ColoredCode> createState() => _ColoredCodeState();
}

class _ColoredCodeState extends State<ColoredCode>
    with SingleTickerProviderStateMixin {
  late AnimationController _typingController;
  int _numOperations = 0;
  List<Diff>? _diff;

  @override
  void initState() {
    super.initState();
    _typingController = AnimationController(
      vsync: this,
      value: 0.0,
    );
    _typingController.addListener(() {
      setState(() {});
    });

    if (widget.animateFromCode != null) {
      var numOperations = 0;
      _diff = DiffMatchPatch().diff(widget.animateFromCode!, widget.code);
      for (var d in _diff!) {
        if (d.operation == DIFF_DELETE) {
          numOperations += 1;
        } else if (d.operation == DIFF_INSERT) {
          numOperations += d.text.length;
        }
      }
      _numOperations = numOperations;
      var totalMs = numOperations * widget.keystrokeDuration.inMilliseconds;
      if (totalMs > widget.maxAnimationDuration.inMilliseconds) {
        totalMs = widget.maxAnimationDuration.inMilliseconds;
      }
      var duration = Duration(milliseconds: totalMs);
      _typingController.animateTo(
        1.0,
        duration: duration,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _typingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = SlideTheme.of(context)!;

    var codeThemeCopy = Map<String, TextStyle>.from(widget.codeTheme);
    codeThemeCopy['root'] = codeThemeCopy['root']!.copyWith(
      backgroundColor: Colors.transparent,
    );

    String animatedCode;
    if (_typingController.isAnimating &&
        widget.animateFromCode != null &&
        _diff != null) {
      animatedCode = _getAnimatedCode(
        (_typingController.value * _numOperations).floor(),
      );
    } else {
      animatedCode = widget.code;
    }

    return HighlightView(
      animatedCode,
      language: widget.language,
      theme: codeThemeCopy,
      textStyle: widget.textStyle ?? theme.textTheme.code,
    );
  }

  String _getAnimatedCode(int frame) {
    frame.clamp(0, _numOperations - 1);

    // Animate insertions and deletions.
    int operationCount = 0;
    int diffIdx = 0;
    int insertIdx = 0;
    var animatedCode = '';
    while (operationCount < frame) {
      var diff = _diff![diffIdx];

      if (diff.operation == DIFF_EQUAL) {
        // Equal.
        animatedCode += diff.text;
        diffIdx += 1;
      } else if (diff.operation == DIFF_DELETE) {
        // Delete.
        diffIdx += 1;
        operationCount += 1;
      } else {
        // Insert.
        animatedCode += diff.text.substring(insertIdx, insertIdx + 1);

        insertIdx += 1;
        operationCount += 1;
        if (insertIdx == diff.text.length) {
          diffIdx += 1;
          insertIdx = 0;
        }
      }
    }

    // Add remaining old code.
    while (diffIdx < _diff!.length) {
      var diff = _diff![diffIdx];
      if (diff.operation == DIFF_EQUAL) {
        // Equal.
        animatedCode += diff.text;
      } else if (diff.operation == DIFF_DELETE) {
        // Delete.
        animatedCode += diff.text;
      }
      diffIdx += 1;
    }

    return animatedCode;
  }
}
