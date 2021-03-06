import 'package:dino_run/game/audio_manager.dart';
import 'package:dino_run/screens/main_menu.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  await Flame.util.setLandscape();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  await AudioManager.instance.init([
    '8Bit Platformer Loop.wav',
    'lion_hit.mp3',
    'hurt7.wav',
    'jump14.wav',
    'ES_Lion Roar Long - SFX Producer.mp3'
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Savana Animals',
      theme: ThemeData(
        fontFamily: 'Audiowide',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainMenu(),
      debugShowCheckedModeBanner: false,
    );
  }
}
