import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class BlobView3 extends StatefulWidget {
  const BlobView3({
    required this.radius,
    required this.offset,
    required this.amplitude,
    super.key,
  });

  final double radius;
  final double offset;
  final double amplitude;

  @override
  State<BlobView3> createState() => _BlobView3State();
}

class _BlobView3State extends State<BlobView3> {
  final _blobViewNode = _BlobViewNode();

  @override
  void didUpdateWidget(covariant BlobView3 oldWidget) {
    super.didUpdateWidget(oldWidget);
    _blobViewNode._radius = widget.radius;
    _blobViewNode._offset = widget.offset;
  }

  @override
  Widget build(BuildContext context) {
    return SpriteWidget(_blobViewNode);
  }
}

class _BlobViewNode extends NodeWithSize {
  double _radius = 5.0;
  double _offset = 256.0;

  _BlobViewNode() : super(const Size(512, 512));

  @override
  void paint(Canvas canvas) {
    super.paint(canvas);

    canvas.drawCircle(
      Offset(256, _offset),
      _radius * 20,
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0,
    );

    canvas.drawCircle(
      Offset(256, _offset - 512),
      _radius * 20,
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0,
    );

    canvas.drawCircle(
      Offset(256, _offset + 512),
      _radius * 20,
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0,
    );
  }
}
