import 'dart:math';
import 'dart:ui';

import 'package:dino_run/game/animals.dart';
import 'package:dino_run/game/savana_friends.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';

class FriendsManager extends Component with HasGameRef<SavanaFriends> {
  Random _random;
  Timer _timer;
  int _counts;

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
