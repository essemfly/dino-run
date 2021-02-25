import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/foundation.dart';

import 'constant.dart';

enum EnemyType { Duck, Pig, Chicken, Lion }

class EnemyData {
  final String imageName;
  final int textureWidth;
  final int textureHeight;
  final int nColumns;
  final int nRows;
  final bool canFly;
  final int speed;

  EnemyData({
    @required this.imageName,
    @required this.textureWidth,
    @required this.textureHeight,
    @required this.nColumns,
    @required this.nRows,
    @required this.canFly,
    @required this.speed,
  });
}

class Enemy extends AnimationComponent {
  EnemyData _myData;
  static Random _random = Random();

  static Map<EnemyType, EnemyData> _enemyDetails = {
    EnemyType.Pig: EnemyData(
      imageName: 'pig.png',
      textureWidth: 36,
      textureHeight: 30,
      nColumns: 12,
      nRows: 1,
      canFly: true,
      speed: 200,
    ),
    EnemyType.Duck: EnemyData(
      imageName: 'duck.png',
      textureWidth: 36,
      textureHeight: 30,
      nColumns: 10,
      nRows: 1,
      canFly: false,
      speed: 350,
    ),
    EnemyType.Chicken: EnemyData(
      imageName: 'chicken.png',
      textureWidth: 32,
      textureHeight: 34,
      nColumns: 14,
      nRows: 1,
      canFly: false,
      speed: 300,
    ),
    EnemyType.Lion: EnemyData(
      imageName: 'LionSprites.png',
      textureWidth: 61,
      textureHeight: 40,
      nColumns: 6,
      nRows: 1,
      canFly: false,
      speed: 200,
    ),
  };

  Enemy(EnemyType enemyType) : super.empty() {
    _myData = _enemyDetails[enemyType];
    final spriteSheet = SpriteSheet(
        imageName: _myData.imageName,
        textureWidth: _myData.textureWidth,
        textureHeight: _myData.textureHeight,
        columns: _myData.nColumns,
        rows: _myData.nRows);

    this.animation = spriteSheet.createAnimation(0,
        from: 0, to: (_myData.nColumns - 1), stepTime: 0.1);

    this.anchor = Anchor.center;
  }



  @override
  void resize(Size size) {
    super.resize(size);

    double scaleFactor =
        (size.width / numberOfTilesAlongWidth) / _myData.textureWidth;
    this.height = _myData.textureHeight * scaleFactor;
    this.width = _myData.textureWidth * scaleFactor;
    this.x = size.width + this.width;
    this.x = 0;
    this.y = size.height - groundHeight - (this.height / 2);

    if (_myData.canFly && _random.nextBool()) {
      this.y -= this.height;
    }
  }

  @override
  void update(double t) {
    super.update(t);
    this.x += _myData.speed * t;
  }

  @override
  bool destroy() {
    return (this.x > this.width * (numberOfTilesAlongWidth + 1));
  }
}
