import 'dart:ui';
import 'package:dino_run/game/audio_manager.dart';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/time.dart';
import 'package:flutter/foundation.dart';

import 'constant.dart';

class Dino extends AnimationComponent {
  Animation _runAnimation;
  Animation _hitAnimation;
  Timer _timer;
  bool _isHit;

  double speedX = 0.0;
  double speedY = 0.0;
  double yMax = 0.0;
  double xMax = 0.0;

  ValueNotifier<int> life;

  Dino() : super.empty() {
    // 0 - 3 = idle
    // 4 - 10 = run
    // 11 - 13 = kick
    // 14 - 16 = hit
    // 17 - 23 = Sprint

    final spriteSheet = SpriteSheet(
        imageName: 'BabyRun.png',
        textureWidth: 225,
        textureHeight: 262,
        columns: 4,
        rows: 1);

    _runAnimation =
        spriteSheet.createAnimation(0, from: 0, to: 3, stepTime: 0.1);

    // _hitAnimation =
    //     spriteSheet.createAnimation(0, from: 14, to: 16, stepTime: 0.1);

    this.animation = _runAnimation;

    _timer = Timer(1, callback: () {
      run();
    });
    _isHit = false;

    this.anchor = Anchor.center;
    life = ValueNotifier(3);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    this.height = this.width = size.width / numberOfTilesAlongWidth;
    this.x = (size.width - this.width) / 2;
    this.y =
        size.height - groundHeight - (this.height / 2) + dinoTopBottomSpacing;
    this.xMax = size.width;
    this.yMax = this.y;
  }

  @override
  void update(double t) {
    super.update(t);

    this.speedY += GRAVITY * t;
    this.y += this.speedY * t;
    this.speedX -= 0.1;
    this.x += this.speedX;

    if (isOnGround()) {
      this.y = this.yMax;
      this.speedY = 0.0;
    }

    if (this.x > this.xMax) {
      this.x = this.xMax;
      this.speedX = 0.0;
    }
    if (this.x < 0) {
      this.x = 0;
      this.speedX = 0.0;
    }

    _timer.update(t);
  }

  bool isOnGround() {
    return (this.y >= this.yMax);
  }

  void run() {
    _isHit = false;
    this.animation = _runAnimation;
  }

  void hit() {
    if (!_isHit) {
      // this.animation = _hitAnimation;
      _timer.start();

      life.value -= 1;
      AudioManager.instance.playSfx('ES_Lion Roar Long - SFX Producer.mp3');
      _isHit = true;
    }
  }

  void jump() {
    if (isOnGround()) {
      this.speedY = -500;
      this.speedX = 4;
      AudioManager.instance.playSfx('jump14.wav');
    }
  }

  @override
  bool destroy() {
    return _isHit;
  }
}
