import 'package:flutter/material.dart';
import 'package:fluttercon_serverpod/src/slides/building_the_game.dart';
import 'package:fluttercon_serverpod/src/slides/collision_detection.dart';
import 'package:fluttercon_serverpod/src/slides/intro.dart';
import 'package:fluttercon_serverpod/src/slides/realtime_communications.dart';
import 'package:fluttercon_serverpod/src/slides/serverpod_basics.dart';
import 'package:slick_slides/slick_slides.dart';

void main() async {
  await SlickSlides().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Presentation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark,
        ),
        visualDensity: VisualDensity.compact,
        useMaterial3: true,
      ),
      home: const Scaffold(body: MyHomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SlideDeck(
      slides: [
        // ...introSlides,
        // ...serverpodBasicsSlides,
        // ...realtimeCommunicationsSlides,
        // ...buildingTheGameSlides,
        ...collisionDetectionSlides,
      ],
    );
  }
}
