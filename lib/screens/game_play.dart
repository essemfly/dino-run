import 'package:dino_run/game/game.dart';
import 'package:flutter/material.dart';

class GamePlay extends StatelessWidget {
  final DinoGame _dinoGame = DinoGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _dinoGame.widget,
    );
  }
}
