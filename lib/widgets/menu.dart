import 'package:dino_run/screens/game_choose.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final Function onSettingsPressed;

  const Menu({Key key, @required this.onSettingsPressed})
      : assert(onSettingsPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Savana Friends',
          style: TextStyle(
            fontSize: 60.0,
            color: Colors.white,
          ),
        ),
        RaisedButton(
          child: Text(
            'Play',
            style: TextStyle(fontSize: 30.0),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => GameChoose()));
          },
        ),
        RaisedButton(
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 30.0),
          ),
          onPressed: onSettingsPressed,
        ),
      ],
    );
  }
}
