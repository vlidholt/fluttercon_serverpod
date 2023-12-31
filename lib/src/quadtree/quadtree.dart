import 'dart:math';

import 'object.dart';
import 'providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quadtree_dart/quadtree_dart.dart';
import 'package:vector_math/vector_math.dart' as vec;

class QuadtreeView extends StatefulWidget {
  const QuadtreeView({super.key});

  @override
  QuadtreeViewState createState() => QuadtreeViewState();
}

class QuadtreeViewState extends State<QuadtreeView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Size? previousSize;
  bool shouldHaveVelocity = true;
  bool shouldCollide = true;
  double spotlightDiameter = 100;

  Quadtree<VelocityObject>? quadtree;

  List<VelocityObject> objects = [];
  List<VelocityObject> matchedObjects = [];
  List<Rect> nodes = [];

  Offset? hoveringOffset;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(hours: 69420),
    )
      ..addListener(() {
        if (quadtree == null) return;

        objects = quadtree!.retrieve(quadtree!.bounds);

        quadtree!.clear();
        for (final o in objects) {
          if (shouldHaveVelocity) {
            bool collided = false;
            if (shouldCollide) {
              for (final o2 in quadtree!.retrieve(o)) {
                if (o.intersects(o2)) {
                  collided = true;
                  o.collide(o2);
                  break;
                }
              }
            }

            if (!collided) {
              if (o.x + o.width >=
                      quadtree!.bounds.x + quadtree!.bounds.width ||
                  o.x <= quadtree!.bounds.x) {
                o.collideLR();
              }

              if (o.y + o.height >=
                      quadtree!.bounds.y + quadtree!.bounds.height ||
                  o.y <= quadtree!.bounds.y) {
                o.collideTB();
              }
            }

            o.tick();
          }

          quadtree!.insert(o);
        }
        nodes = quadtree!.retrieveAllNodes();

        if (hoveringOffset != null) {
          matchedObjects = quadtree!.retrieve(Rect(
            x: hoveringOffset!.dx - spotlightDiameter / 2,
            y: hoveringOffset!.dy - spotlightDiameter / 2,
            height: spotlightDiameter,
            width: spotlightDiameter,
          ));
        }

        setState(() {});
      })
      ..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _insertRandomNode() {
    final random = Random();

    final lower = context.read(lowerNodeDiameterProvider).state;
    final higher = context.read(higherNodeDiameterProvider).state;
    final diameter = lower + random.nextDouble() * (higher - lower);

    final lowerV = context.read(lowerVelocityProvider).state;
    final higherV = context.read(higherVelocityProvider).state;
    final velocity = vec.Vector2(
      lowerV + random.nextDouble() * (higherV - lowerV),
      lowerV + random.nextDouble() * (higherV - lowerV),
    );

    var x = random.nextDouble() * 1920;
    var y = random.nextDouble() * 1080;

    context.read(quadtreeProvider.notifier).insert(
          x,
          y,
          diameter: diameter,
          dx: velocity.x,
          dy: velocity.y,
        );
  }

  bool _addedNodes = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black),
        LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            if (size != previousSize) {
              previousSize = size;
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => context.read(boundsProvider).state = size,
              );
            }

            if (!_addedNodes) {
              _addedNodes = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                for (int i = 0; i < 100; i++) {
                  _insertRandomNode();
                }
              });
            }

            return Consumer(
              builder: (context, watch, _) {
                quadtree = watch(quadtreeProvider);
                shouldHaveVelocity = watch(shouldHaveVelocityProvider).state;
                shouldCollide = watch(shouldCollideProvider).state;
                spotlightDiameter = watch(spotlightDiameterProvider).state;

                return Container(
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: InteractiveViewer(
                    child: MouseRegion(
                      onHover: (details) =>
                          hoveringOffset = details.localPosition,
                      onExit: (_) => hoveringOffset = null,
                      child: GestureDetector(
                        // onTapDown: (details) => insertNode(context, details),
                        child: Stack(
                          children: [
                            if (hoveringOffset != null)
                              Transform.translate(
                                offset: hoveringOffset! -
                                    Offset(
                                      spotlightDiameter / 2,
                                      spotlightDiameter / 2,
                                    ),
                                child: Container(
                                  width: spotlightDiameter,
                                  height: spotlightDiameter,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    color: Colors.blue.withOpacity(0.1),
                                  ),
                                ),
                              ),
                            Flow(
                              delegate: NodeFlowDelegate(nodes),
                              children: nodes
                                  .map(
                                    (node) => Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.05),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                      width: node.width,
                                      height: node.height,
                                    ),
                                  )
                                  .toList(),
                            ),
                            Flow(
                              delegate: ObjectFlowDelegate(objects),
                              children: objects.map(
                                (object) {
                                  final inQuery =
                                      matchedObjects.contains(object);
                                  bool intersectsHitBox = false;
                                  if (hoveringOffset != null && inQuery) {
                                    final offset = hoveringOffset! -
                                        Offset(
                                          spotlightDiameter / 2,
                                          spotlightDiameter / 2,
                                        );
                                    intersectsHitBox = Rect(
                                      x: offset.dx,
                                      y: offset.dy,
                                      width: spotlightDiameter,
                                      height: spotlightDiameter,
                                    ).intersects(object);
                                  }

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: hoveringOffset == null
                                          ? Colors.red
                                          : (intersectsHitBox
                                              ? Colors.blue
                                              : inQuery
                                                  ? Colors.purple
                                                  : Colors.red),
                                      shape: BoxShape.circle,
                                    ),
                                    width: object.width,
                                    height: object.height,
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class NodeFlowDelegate extends FlowDelegate {
  NodeFlowDelegate(this.nodes);

  final List<Rect> nodes;

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          nodes[i].x,
          nodes[i].y,
          0,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(NodeFlowDelegate oldDelegate) => true;
}

class ObjectFlowDelegate extends FlowDelegate {
  ObjectFlowDelegate(this.objects);

  final List<VelocityObject> objects;

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      final object = objects[i];
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          object.x,
          object.y,
          0,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(ObjectFlowDelegate oldDelegate) => true;
}
