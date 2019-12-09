import 'package:flutter/material.dart';
import 'package:game/main.dart';
import 'package:game/GameCharacters/ghost.dart';
import 'package:game/GameCharacters/obstacle_1.dart';
import 'package:game/GameCharacters/obstacle2.dart';

import 'dart:math';
import 'package:flutter/services.dart';

class GameBackground extends StatefulWidget {
  static int scoreCounter = 0;
  static int bestScore = 0;
  @override
  _GameBackgroundState createState() => _GameBackgroundState();
}

class _GameBackgroundState extends State<GameBackground>
    with TickerProviderStateMixin {
  AnimationController jumpingController;
  Animation jumpingAnimation;
  AnimatedWidget currentObstacle;
  AnimationController obstacleController;
  Animation obstacleAnimation;

  @override
  void initState() {
    super.initState();

    jumpingController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    jumpingAnimation = new CurvedAnimation(
      curve: Curves.ease,
      parent: jumpingController,
    );
    jumpingAnimation.addStatusListener(listener);
    obstacleController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    obstacleAnimation =
        new CurvedAnimation(parent: obstacleController, curve: Curves.linear);
    obstacleAnimation.addStatusListener(listenerObstacle);
    obstacleController.forward();
  }

  void listener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      jumpingController.animateBack(0.0, duration: Duration(milliseconds: 300));
    }
  }

  Animation getAnimation() {
    return this.jumpingAnimation;
  }

  var counter = 0;
  void listenerObstacle(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        GameBackground.scoreCounter++;
        obstacleController.animateTo(0.0, duration: Duration(seconds: 0));
      });

      obstacleController.forward();
    }
  }

  void dispose() {
    super.dispose();
    jumpingController.dispose();
    obstacleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Ghost ghost = new Ghost(
      animation: jumpingAnimation,
    );

    List<AnimatedWidget> obstacles = new List<AnimatedWidget>();
    Obstacle1 o1 = new Obstacle1(
      animation: obstacleAnimation,
    );

    Obstacle2 o2 = new Obstacle2(
      animation: obstacleAnimation,
    );
    int x = Random().nextInt(2);
    this.obstacleAnimation.addListener(() {
      if (x == 0) {
        if ((o1.getd() * 100).toInt() / 100 <= -0.3 &&
            (o1.getd() * 100).toInt() / 100 >= -0.6 &&
            ghost.getd() >= -0.07) {
          Navigator.push(context,
              PageRouteBuilder(pageBuilder: (context, _, __) => Menu()));
          if (GameBackground.scoreCounter > GameBackground.bestScore) {
            GameBackground.bestScore = GameBackground.scoreCounter;
          }
          GameBackground.scoreCounter = 0;
          setState(() {
            GameBackground.scoreCounter = 0;
          });
          jumpingController.reset();
          obstacleController.reset();
          if (jumpingAnimation.status == AnimationStatus.dismissed) {
            obstacleController.forward();
          }
        }
      } else {
        if ((o2.getd() * 10).toInt() / 10 <= -0.3 &&
            (o2.getd() * 10).toInt() / 10 >= -0.6 &&
            ghost.getd() >= -0.07) {
          Navigator.push(context,
              PageRouteBuilder(pageBuilder: (context, _, __) => Menu()));
          if (GameBackground.scoreCounter > GameBackground.bestScore) {
            GameBackground.bestScore = GameBackground.scoreCounter;
          }
          GameBackground.scoreCounter = 0;
          setState(() {
            GameBackground.scoreCounter = 0;
          });
          jumpingController.reset();
          obstacleController.reset();
          if (jumpingAnimation.status == AnimationStatus.dismissed) {
            obstacleController.forward();
          }
        }
      }
    });

    obstacles.add(o1);
    obstacles.add(o2);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    return Scaffold(
        backgroundColor: Colors.black,
        body: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (jumpingAnimation.isDismissed) {
              jumpingController.forward();
            }
          },
          child: Container(
            color: Colors.black,
            height: height,
            width: width,
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  height: height / 1.8,
                  width: width,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.white, width: 1))),
                ),
                Align(
                    alignment: Alignment(0.8, -0.8),
                    child: Text(
                      '${GameBackground.scoreCounter}  HI ${GameBackground.bestScore}',
                      style: TextStyle(
                          fontFamily: 'Arcade',
                          color: Colors.grey,
                          fontSize: 18),
                    )),
                obstacles.elementAt(x),
                ghost,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      color: Colors.black,
                      height: height,
                      width: 50,
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      color: Colors.black,
                      height: height,
                      width: 50,
                      alignment: Alignment.centerRight,
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
