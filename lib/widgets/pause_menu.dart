import 'package:dino_run/screens/main_menu.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  final Function onResumePressed;
  final Function onResetPressed;

  const PauseMenu({
    Key key,
    @required this.onResetPressed,
    @required this.onResumePressed,
  })  : assert(onResumePressed != null, onResetPressed != null),
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
                'Paused',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MainMenu()));
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {
                        onResumePressed.call();
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
