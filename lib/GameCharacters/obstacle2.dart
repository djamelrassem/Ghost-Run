import 'package:flutter/material.dart';

class Obstacle2 extends AnimatedWidget {
  Obstacle2({Key key, @required Animation animation})
      : super(key: key, listenable: animation);

  final moving = new Tween(begin: 1.0, end: -1.0);
  double getd() {
    return moving.evaluate(listenable);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(getd(), -0.03),
      child: Container(
          height: 50,
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlutterLogo(
                size: 50,
                colors: Colors.yellow,
              ),
              FlutterLogo(size: 50, colors: Colors.red)
            ],
          )),
    );
  }
}
