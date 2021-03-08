import 'package:flutter/material.dart';

class HUDFriends extends StatelessWidget {
  final Function onPausePressed;

  const HUDFriends({Key key, @required this.onPausePressed})
      : assert(onPausePressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.pause, color: Colors.white, size: 30.0),
          onPressed: () {
            onPausePressed.call();
          },
        ),
      ],
    );
  }
}
