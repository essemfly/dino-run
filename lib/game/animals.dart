import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/foundation.dart';

import 'constant.dart';

enum AnimalType { Bear, Deer, Elephant, Giraffe, Lion, Rabbit }

Map<AnimalType, AnimalData> _enemyDetails = {
  AnimalType.Bear: AnimalData(
    imageName: 'savana/bear.png',
    textureWidth: 275,
    textureHeight: 306,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 80,
  ),
  AnimalType.Deer: AnimalData(
    imageName: 'savana/deer.png',
    textureWidth: 282,
    textureHeight: 292,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 120,
  ),
  AnimalType.Elephant: AnimalData(
    imageName: 'savana/elephant.png',
    textureWidth: 391,
    textureHeight: 311,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 70,
  ),
  AnimalType.Giraffe: AnimalData(
    imageName: 'savana/giraffe.png',
    textureWidth: 179,
    textureHeight: 321,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 100,
  ),
  AnimalType.Lion: AnimalData(
    imageName: 'savana/lion.png',
    textureWidth: 254,
    textureHeight: 271,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 110,
  ),
  AnimalType.Rabbit: AnimalData(
    imageName: 'savana/rabbit.png',
    textureWidth: 185,
    textureHeight: 182,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 90,
  ),
};

class AnimalData {
  final String imageName;
  final int textureWidth;
  final int textureHeight;
  final int nColumns;
  final int nRows;
  final bool canFly;
  final int speed;

  AnimalData({
    @required this.imageName,
    @required this.textureWidth,
    @required this.textureHeight,
    @required this.nColumns,
    @required this.nRows,
    @required this.canFly,
    @required this.speed,
  });
}

class Animal extends AnimationComponent {
  AnimalData _myData;
  static Random _random = Random();

  Animal(AnimalType enemyType) : super.empty() {
    _myData = _enemyDetails[enemyType];
    final spriteSheet = SpriteSheet(
        imageName: _myData.imageName,
        textureWidth: _myData.textureWidth,
        textureHeight: _myData.textureHeight,
        columns: _myData.nColumns,
        rows: _myData.nRows);

    this.animation = spriteSheet.createAnimation(0,
        from: 0, to: (_myData.nColumns), stepTime: 0.1);

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
    this.y = size.height - groundHeight - (this.height / 2);

    if (_myData.canFly && _random.nextBool()) {
      this.y -= this.height;
    }
  }

  @override
  void update(double t) {
    super.update(t);
    if (this.x > 100) {
      this.x -= _myData.speed * t;
    }
  }

  @override
  bool destroy() {
    return (this.x > this.width * (numberOfTilesAlongWidth + 1));
  }

  void reverse() {
    String reverseImageName = _myData.imageName.replaceFirst('.', '_flip.');
    print(reverseImageName);
    final spriteSheet = SpriteSheet(
        imageName: reverseImageName,
        textureWidth: _myData.textureWidth,
        textureHeight: _myData.textureHeight,
        columns: _myData.nColumns,
        rows: _myData.nRows);

    this.animation = spriteSheet.createAnimation(0,
        from: 0, to: (_myData.nColumns), stepTime: 0.1);
    this.x = this.x - 10;
  }
}
