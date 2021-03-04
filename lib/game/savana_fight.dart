import 'dart:ui';

import 'package:dino_run/game/audio_manager.dart';
import 'package:dino_run/game/dino.dart';
import 'package:dino_run/game/enemy_manager.dart';
import 'package:dino_run/widgets/game_over_menu.dart';
import 'package:dino_run/widgets/hud.dart';
import 'package:dino_run/widgets/pause_menu.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/game/base_game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';

import 'enemy.dart';

class SavanaFight extends BaseGame with TapDetector, HasWidgetsOverlay {
  Dino _dino;
  ParallaxComponent _parallaxComponent;
  TextComponent _scoreText;
  double _elapsedTime = 0.0;
  int score;
  EnemyManager _enemyManager;
  bool _isGameOver = false;
  bool _isGamePaused = false;

  SavanaFight() {
    _parallaxComponent = ParallaxComponent([
      ParallaxImage('background/bg.png'),
      ParallaxImage('background/hills@3x 1.png', fill: LayerFill.none),
      ParallaxImage('background/cloud@3x 1.png', alignment: Alignment(-0.8, -1.0), fill: LayerFill.none),
      ParallaxImage('background/cloud@3x 2.png', alignment: Alignment(0.3, -0.9), fill: LayerFill.none),
      ParallaxImage('background/trees@3x 1.png', fill: LayerFill.none),
      ParallaxImage('background/land.png', fill: LayerFill.none),
    ], baseSpeed: Offset(40, 0), layerDelta: Offset(10, 0));

    add(_parallaxComponent);
    _dino = Dino();
    add(_dino);

    _enemyManager = EnemyManager();
    add(_enemyManager);

    score = 0;
    _scoreText = TextComponent(score.toString(),
        config: TextConfig(fontFamily: 'Audiowide', color: Colors.white));
    add(_scoreText);

    addWidgetOverlay('Hud', HUD(onPausePressed: pauseGame, life: _dino.life));

    // AudioManager.instance.startBgm('8Bit Platformer Loop.wav');
  }

  @override
  void resize(Size size) {
    super.resize(size);
    _scoreText
        .setByPosition(Position((size.width / 2) - (_scoreText.width / 2), 0));
  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    if (!_isGameOver && !_isGamePaused) {
      _dino.jump();
    }
  }

  @override
  void update(double t) {
    super.update(t);
    _elapsedTime += t;
    if (_elapsedTime > (1 / 60)) {
      _elapsedTime = 0.0;
      score += 1;
      _scoreText.text = score.toString();
    }

    components.whereType<Enemy>().forEach((enemy) {
      if (_dino.distance(enemy) < 30) {
        _dino.hit();
        enemy.reverse();
      }
    });

    if (_dino.life.value <= 0) {
      gameOver();
    }
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        this.pauseGame();
        break;
      case AppLifecycleState.paused:
        this.pauseGame();
        break;
      case AppLifecycleState.detached:
        this.pauseGame();
        break;
    }
  }

  void pauseGame() {
    pauseEngine();
    if (!_isGameOver) {
      _isGamePaused = true;
      addWidgetOverlay('PauseMenu', PauseMenu(onResumePressed: resumeGame));
      AudioManager.instance.pauseBgm();
    }
  }

  void resumeGame() {
    removeWidgetOverlay('PauseMenu');
    resumeEngine();
    AudioManager.instance.resumeBgm();
    _isGamePaused = false;
  }

  void gameOver() {
    _isGameOver = true;
    pauseEngine();
    addWidgetOverlay(
        'GameOverMenu', GameOverMenu(score: score, onRestartPressed: reset));
    AudioManager.instance.pauseBgm();
  }

  void reset() {
    this.score = 0;
    _dino.life.value = 3;
    _dino.run();
    _enemyManager.reset();

    components.whereType<Enemy>().forEach((enemy) {
      this.markToRemove(enemy);
    });

    removeWidgetOverlay('GameOverMenu');
    resumeEngine();
    AudioManager.instance.resumeBgm();
    _isGameOver = false;
  }

  @override
  void onDetach() {
    AudioManager.instance.stopBgm();
    super.onDetach();
  }
}
