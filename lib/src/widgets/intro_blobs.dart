import 'package:bacterialboom_flutter/bacterialboom.dart';
import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class IntroBlobsView extends StatefulWidget {
  const IntroBlobsView({
    super.key,
  });

  @override
  State<IntroBlobsView> createState() => _IntroBlobsViewState();
}

class _IntroBlobsViewState extends State<IntroBlobsView> {
  final _blobViewNode = _BlobViewNode();

  @override
  Widget build(BuildContext context) {
    return SpriteWidget(_blobViewNode);
  }
}

class _BlobViewNode extends NodeWithSize {
  late final BlobNode blob;

  _BlobViewNode() : super(const Size(1920, 1080)) {
    addChild(
      BlobNode(
        userId: 0,
        blobId: 0,
        maxVelocity: 0,
        radius: 8.0,
        colorIdx: 1,
        isDummy: true,
      )
        ..scale = 20
        ..position = const Offset(100, 200),
    );

    addChild(
      BlobNode(
        userId: 0,
        blobId: 0,
        maxVelocity: 0,
        radius: 12.0,
        colorIdx: 2,
        isDummy: true,
      )
        ..scale = 20
        ..position = const Offset(1500, 1000),
    );

    addChild(
      BlobNode(
        userId: 0,
        blobId: 0,
        maxVelocity: 0,
        radius: 5.0,
        colorIdx: 3,
        isDummy: true,
      )
        ..scale = 20
        ..position = const Offset(1200, 300),
    );

    addChild(
      BlobNode(
        userId: 0,
        blobId: 0,
        maxVelocity: 0,
        radius: 4.0,
        colorIdx: 4,
        isDummy: true,
      )
        ..scale = 20
        ..position = const Offset(500, 800),
    );

    addChild(
      BlobNode(
        userId: 0,
        blobId: 0,
        maxVelocity: 0,
        radius: 6.0,
        colorIdx: 5,
        isDummy: true,
      )
        ..scale = 20
        ..position = const Offset(1800, 100),
    );

    addChild(
      BlobNode(
        userId: 0,
        blobId: 0,
        maxVelocity: 0,
        radius: 10.0,
        colorIdx: 6,
        isDummy: true,
      )
        ..scale = 20
        ..position = const Offset(600, 100),
    );

    addChild(
      BlobNode(
        userId: 0,
        blobId: 0,
        maxVelocity: 0,
        radius: 5.0,
        colorIdx: 7,
        isDummy: true,
      )
        ..scale = 20
        ..position = const Offset(200, 1000),
    );
  }
}
