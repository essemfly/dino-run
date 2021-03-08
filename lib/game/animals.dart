import 'dart:math';
import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flutter/foundation.dart';

import 'audio_manager.dart';
import 'constant.dart';

enum AnimalType { Bear, Deer, Elephant, Giraffe, Lion, Rabbit }
enum AnimalStatus { Rushing, Following }

Map<AnimalType, AnimalData> _enemyDetails = {
  AnimalType.Bear: AnimalData(
    imageName: 'savana/bear.png',
    textureWidth: 275,
    textureHeight: 306,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 220,
    appearSoundPath: 'animals/Bear-sound.mp3',
    growlSoundPath: 'animals/Bear-sound.mp3',
  ),
  AnimalType.Deer: AnimalData(
    imageName: 'savana/deer.png',
    textureWidth: 282,
    textureHeight: 292,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 230,
    appearSoundPath: 'animals/Deer-sound.mp3',
    growlSoundPath: 'animals/Deer-sound.mp3',
  ),
  AnimalType.Elephant: AnimalData(
    imageName: 'savana/elephant.png',
    textureWidth: 391,
    textureHeight: 311,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 240,
    appearSoundPath: 'animals/Elephant-sound.mp3',
    growlSoundPath: 'animals/Elephant-sound.mp3',
  ),
  AnimalType.Giraffe: AnimalData(
    imageName: 'savana/giraffe.png',
    textureWidth: 179,
    textureHeight: 321,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 250,
    appearSoundPath: 'animals/Giraffe-sound.mp3',
    growlSoundPath: 'animals/Giraffe-sound.mp3',
  ),
  AnimalType.Lion: AnimalData(
    imageName: 'savana/lion.png',
    textureWidth: 254,
    textureHeight: 271,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 260,
    appearSoundPath: 'animals/Lion-sound.mp3',
    growlSoundPath: 'animals/Lion-sound.mp3',
  ),
  AnimalType.Rabbit: AnimalData(
    imageName: 'savana/rabbit.png',
    textureWidth: 185,
    textureHeight: 182,
    nColumns: 1,
    nRows: 1,
    canFly: false,
    speed: 270,
    appearSoundPath: 'animals/Rabbit-sound.mp3',
    growlSoundPath: 'animals/Rabbit-sound.mp3',
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
  final String appearSoundPath;
  final String growlSoundPath;

  AnimalData({
    @required this.imageName,
    @required this.textureWidth,
    @required this.textureHeight,
    @required this.nColumns,
    @required this.nRows,
    @required this.canFly,
    @required this.speed,
    @required this.appearSoundPath,
    @required this.growlSoundPath,
  });
}

class Animal extends AnimationComponent {
  AnimalData _myData;
  static Random _random = Random();
  Animation actionAnimation;
  double speedX = 0.0;
  double speedY = 0.0;
  double yMax = 0.0;
  double xMax = 0.0;
  AnimalStatus status = AnimalStatus.Rushing;

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

    this.actionAnimation = spriteSheet.createAnimation(0,
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

    setLocation(size.width + this.width,
        size.height - groundHeight - (this.height / 2));

    this.xMax = size.width;
    this.yMax = this.y;

    if (_myData.canFly && _random.nextBool()) {
      this.y -= this.height;
    }
  }

  @override
  void update(double t) {
    super.update(t);
    this.x -= _myData.speed * t;

    this.speedY += GRAVITY * t;
    this.y += this.speedY * t;

    if (isOnGround()) {
      this.y = this.yMax;
      this.speedY = 0.0;
    }
  }

  bool isOnGround() {
    return (this.y >= this.yMax);
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
    this.status = AnimalStatus.Following;
  }

  void setLocation(double x, double y) {
    this.x = x;
    this.y = y;
  }

  void moveLocation(double x, double y) {}

  void appear() {
    AudioManager.instance.playSfx(_myData.appearSoundPath);
  }

  void growl() {
    AudioManager.instance.playSfx(_myData.growlSoundPath);
  }

  void jump() {
    this.speedY = -500;
  }
}
