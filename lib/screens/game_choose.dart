import 'dart:math';
import 'package:dino_run/game/savana_fight.dart';
import 'package:dino_run/game/savana_friends.dart';
import 'package:dino_run/screens/game_play.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

enum GameType { Friends, Fight }

class GameData {
  final String title;
  final String subtitle;
  final IconData icons;
  final String bgImagePath;
  final BaseGame gameClass;

  GameData(
      {this.title,
      this.subtitle,
      this.icons,
      this.bgImagePath,
      this.gameClass});
}

class GameChoose extends StatefulWidget {
  @override
  _GameChooseState createState() => _GameChooseState();
}

class _GameChooseState extends State<GameChoose> {
  List<GameData> gameData;

  void initState() {
    super.initState();
    gameData = [
      GameData(
        title: 'Savana Round and Round',
        subtitle: 'Collect Friends',
        icons: Icons.brightness_5,
        bgImagePath: 'assets/images/savana/kid.png',
        gameClass: SavanaFriends(),
      ),
      GameData(
        title: 'Savana Fight',
        subtitle: 'Fight and live longer',
        icons: Icons.people,
        bgImagePath: 'assets/images/savana/lion.png',
        gameClass: SavanaFight(),
      )
    ];
  }

  Widget _buildList(context) => ListView(
        scrollDirection: Axis.horizontal,
        children: gameData.map((data) => _tile(data, context)).toList(),
      );

  InkWell _tile(GameData gameData, BuildContext context) => InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => GamePlay(
                    gameData: gameData,
                  )));
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.grey.withOpacity(0.0),
                        Colors.grey.withOpacity(1.0),
                      ],
                      stops: [
                        0.0,
                        1.0
                      ])),
            ),
            Container(
              width: 300,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(0.2),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    //I assumed you want to occupy the entire space of the card
                    image: AssetImage('assets/images/savana/bear.png'),
                  )),
              child: ListTile(
                title: Text(
                  gameData.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(gameData.subtitle),
                leading: Icon(
                  gameData.icons,
                  color: Colors.brown[500],
                ),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(context),
    );
  }
}
