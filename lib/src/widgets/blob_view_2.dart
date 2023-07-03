import 'dart:math';

import 'package:bacterialboom_flutter/bacterialboom.dart';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class BlobView2 extends StatefulWidget {
  const BlobView2({
    required this.radius,
    required this.offset,
    required this.amplitude,
    super.key,
  });

  final double radius;
  final double offset;
  final double amplitude;

  @override
  State<BlobView2> createState() => _BlobView2State();
}

class _BlobView2State extends State<BlobView2> {
  final _blobViewNode = _BlobViewNode();

  @override
  void didUpdateWidget(covariant BlobView2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    _blobViewNode._radius = widget.radius;
    _blobViewNode._offset = widget.offset;
    _blobViewNode._amplitude = widget.amplitude;
  }

  @override
  Widget build(BuildContext context) {
    return SpriteWidget(_blobViewNode);
  }
}

class _BlobViewNode extends NodeWithSize {
  double _radius = 5.0;
  double _offset = 256.0;
  double _amplitude = 0.0;

  _BlobViewNode() : super(const Size(512, 512));

  @override
  void paint(Canvas canvas) {
    super.paint(canvas);

    var noiseCircle = noiseGrid.getCircle(
      xCenter: 256,
      yCenter: _offset,
      radius: _radius * 20,
    );

    var path = Path();
    for (int i = 0; i < 360; i += 1) {
      var rad = i * 2 * pi / 360;

      var variation = _amplitude * noiseCircle[i] * 2;

      var x = (15 + variation * 15) * cos(rad) * 10;
      var y = (15 + variation * 15) * sin(rad) * 10;

      if (i == 0) {
        path.moveTo(x + 256, y + 256);
      } else {
        path.lineTo(x + 256, y + 256);
      }
    }
    path.close();

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0,
    );
  }
}
