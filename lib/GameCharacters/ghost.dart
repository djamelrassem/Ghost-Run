import 'package:flutter/material.dart';

class Ghost extends AnimatedWidget {
  Ghost({Key key, Animation animation})
      : super(key: key, listenable: animation);
  final jumping = new Tween(begin: 0.0, end: -0.6);

  double getd() {
    return jumping.evaluate(listenable);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.5, this.getd()),
      child: ClipPath(
        clipper: GhostShape(),
        child: Container(
          height: 40,
          width: 40,
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CircleAvatar(
                  
                  backgroundColor: Colors.black,
                  radius: 4,
                ),
                SizedBox(width: 4,),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 4,
                ), SizedBox(width: 2,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GhostShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(0, 0, 0, size.height / 2);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height / 2);
    path.quadraticBezierTo(size.width, 0, size.width / 2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
