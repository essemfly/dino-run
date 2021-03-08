import 'package:flutter/material.dart';

class HUDFight extends StatelessWidget {
  final Function onPausePressed;
  final ValueNotifier<int> life;

  const HUDFight({Key key, @required this.onPausePressed, @required this.life})
      : assert(onPausePressed != null),
        assert(life != null),
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
        ValueListenableBuilder(
            valueListenable: life,
            builder: (BuildContext context, value, Widget child) {
              final list = List<Widget>();
              for (int i = 0; i < 3; ++i) {
                list.add(
                  Icon(
                    (i < value) ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.only(right: 30),
                child: Row(
                  children: list,
                ),
              );
            })
      ],
    );
  }
}
