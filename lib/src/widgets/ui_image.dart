import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class UiImage extends StatelessWidget {
  const UiImage(
    this.image, {
    super.key,
  });

  final ui.Image image;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          painter: _UiImagePainter(
            image,
            Size(constraints.maxWidth, constraints.maxHeight),
          ),
        );
      },
    );
  }
}

class _UiImagePainter extends CustomPainter {
  _UiImagePainter(this.image, this.size);
  final ui.Image image;
  final Size size;

  final _paint = Paint();

  @override
  void paint(ui.Canvas canvas, ui.Size size) async {
    var srcRect = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );

    var dstRect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );

    canvas.drawImageRect(image, srcRect, dstRect, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
