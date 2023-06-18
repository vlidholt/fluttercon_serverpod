import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:slick_slides/slick_slides.dart';

class ColoredCode extends StatelessWidget {
  const ColoredCode({
    required this.code,
    this.language = 'dart',
    this.codeTheme = githubTheme,
    this.textStyle,
    super.key,
  });

  final String code;
  final String language;
  final Map<String, TextStyle> codeTheme;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    var theme = SlideTheme.of(context)!;

    var codeThemeCopy = Map<String, TextStyle>.from(codeTheme);
    codeThemeCopy['root'] = theme.textTheme.code.copyWith(
      backgroundColor: Colors.transparent,
    );

    return HighlightView(
      code,
      language: language,
      theme: codeThemeCopy,
      textStyle: textStyle ?? theme.textTheme.code,
    );
  }
}
