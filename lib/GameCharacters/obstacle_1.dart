
import 'package:flutter/material.dart';

class Obstacle1 extends AnimatedWidget {
  Obstacle1({Key key, @required Animation animation})
      : super(key: key, listenable: animation);
  final moving = new Tween(begin: 1.0, end: -1.0);

  double getd(){
    return moving.evaluate(listenable);
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(getd(), -0.035),
      child: Container(
        height: 50,
        width: 50,
        child: FlutterLogo(
          colors: Colors.blue,
        ),
      ),
    );
  }
}