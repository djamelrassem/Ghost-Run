import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game/GameBackground/gameBackgroud.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Menu(),
  ));
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  void initState() {
    super.initState();
    controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = new Tween(begin: 0.0, end: pi).animate(controller);
    controller.repeat();
  }


  void dispose(){
    controller.dispose();
    super.dispose();
  }
  Widget builder(BuildContext context, Widget child) {
    return Transform.rotate(
      angle: animation.value,
      child: Icon(
        Icons.add,
        size: 14,
        color: Colors.red,
      ),
    );
  }


  Widget builder2(BuildContext context, Widget child) {
    return Transform.rotate(
      angle: animation.value,
      child: Icon(
        Icons.add,
        size: 26,
        color: Colors.yellow,
      ),
    );
  }

  Widget builder3(BuildContext context, Widget child) {
    return Transform.rotate(
      angle: animation.value,
      child: Container(
        height: 20,
        width: 20,
        color: Colors.blue,
        child: Center(
            child: Container(
          height: 16,
          width: 16,
          color: Colors.black,
        )),
      ),
    );
  }

  Widget builder4(BuildContext context, Widget child) {
    return Transform.rotate(
      angle: animation.value,
      child: Container(
        height: 18,
        width: 18,
        color: Colors.purpleAccent,
        child: Center(
            child: Container(
          height: 14,
          width: 14,
          color: Colors.black,
        )),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0.2, 0.6),
            child: AnimatedBuilder(
              builder: builder2,
              animation: animation,
            ),
          ),
          Align(
            alignment: Alignment(-0.8, 0.2),
            child: AnimatedBuilder(
              builder: builder3,
              animation: animation,
            ),
          ),
          Align(
            alignment: Alignment(0, -0.7),
            child: AnimatedBuilder(builder: builder4, animation: animation),
          ),
          Center(
            child: InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, _, __) => GameBackground()));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Play',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.blue,
                        fontFamily: 'Arcade',
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Best Score :${GameBackground.bestScore}',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.yellow,
                        fontFamily: 'Arcade',
                        fontWeight: FontWeight.w700),
                  ),
                  AnimatedBuilder(
                    builder: builder,
                    animation: animation,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
