import 'dart:math';
import 'dart:ui';

import 'package:dino_run/game/animals.dart';
import 'package:dino_run/game/savana_friends.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flame/time.dart';
import 'package:flutter/material.dart';

class FriendsManager extends Component with HasGameRef<SavanaFriends> {
  Random _random;
  Timer _timer;
  int _counts;
  TextComponent _countsText;

  FriendsManager() {
    _random = Random();
    _timer = Timer(4, repeat: true, callback: () {
      spawnRandomEnemy();
    });
  }

  void spawnRandomEnemy() {
    if (_counts < 10) {
      final randomNumber = _random.nextInt(AnimalType.values.length);
      final randomEnemyType = AnimalType.values.elementAt(randomNumber);
      final newAnimal = Animal(randomEnemyType);
      gameRef.addLater(newAnimal);
      newAnimal.appear();

      _counts += 1;
      _countsText = TextComponent(_counts.toString(),
          config: TextConfig(fontFamily: 'Audiowide', color: Colors.white));
      gameRef.add(_countsText);
    } else {
      _timer.stop();
    }
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void resize(Size size) {
    super.resize(size);
    _countsText
        .setByPosition(Position((size.width / 2) - (_countsText.width / 2), 0));
  }

  void reset() {
    _counts = 0;
    _timer = Timer(4, repeat: true, callback: () {
      spawnRandomEnemy();
    });
    _timer.start();
  }

  @override
  void update(double t) {
    _timer.update(t);
  }

  @override
  void render(Canvas c) {
    // TODO: implement render
  }
}
