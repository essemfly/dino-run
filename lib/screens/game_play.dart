import 'package:dino_run/screens/game_choose.dart';
import 'package:flutter/material.dart';

class GamePlay extends StatefulWidget {
  GameData gameData;

  GamePlay({this.gameData});

  @override
  _GamePlayState createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  @override
  Widget build(BuildContext context) {
    widget.gameData.gameClass.start();
    return Scaffold(
      body: widget.gameData.gameClass.widget,
    );
  }
}
