import 'package:bacterialboom_flutter/bacterialboom.dart';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class BlobView extends StatefulWidget {
  const BlobView({
    required this.radius,
    super.key,
  });

  final double radius;

  @override
  State<BlobView> createState() => _BlobViewState();
}

class _BlobViewState extends State<BlobView> {
  final _blobViewNode = BlobViewNode();

  @override
  void didUpdateWidget(covariant BlobView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _blobViewNode._radius = widget.radius;
  }

  @override
  Widget build(BuildContext context) {
    return SpriteWidget(_blobViewNode);
  }
}

class BlobViewNode extends NodeWithSize {
  double _radius = 5.0;
  late final BlobNode blob;

  BlobViewNode() : super(const Size(1920, 1080)) {
    blob = BlobNode(
      userId: 0,
      blobId: 0,
      maxVelocity: 0,
      radius: _radius,
      colorIdx: 1,
      isDummy: true,
    );
    blob.scale = 20;
    blob.position = const Offset(1920 / 2, 1080 / 2 + 50);
    addChild(blob);
  }

  @override
  void update(double dt) {
    super.update(dt);
    blob.radius = _radius;
  }
}
