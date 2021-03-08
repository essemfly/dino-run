import 'package:dino_run/screens/main_menu.dart';
import 'package:flutter/material.dart';

class FightGameOverMenu extends StatelessWidget {
  final int score;
  final Function onRestartPressed;

  const FightGameOverMenu({
    Key key,
    @required this.score,
    @required this.onRestartPressed,
  })  : assert(score != null),
        assert(onRestartPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Game Over',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Your score was $score',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: RaisedButton(
                        child: Text(
                          'Retry',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        onPressed: () {
                          onRestartPressed.call();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: RaisedButton(
                        child: Text(
                          'Main Menu',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => MainMenu()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
