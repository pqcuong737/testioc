import 'dart:math';

import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;

  final double initialRedius = 15.0;
  double redius = 0.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 5));

    animation_rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation_radius_in = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 0.1, curve: Curves.elasticIn)));

    animation_radius_out = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          redius = animation_radius_in.value * initialRedius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          redius = animation_radius_out.value * initialRedius;
        }
      });
    });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Center(
        child: RotationTransition(
          turns: animation_rotation,
          child: Stack(
            children: <Widget>[
              Dot(
                radius: 15.0,
                color: Colors.black12,
              ),
              Transform.translate(
                offset: Offset(redius * cos(pi / 4), redius * sin(pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.redAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(redius * cos(2 * pi / 4), redius * sin(2 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.blueAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(redius * cos(3 * pi / 4), redius * sin(3 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.yellowAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(redius * cos(4 * pi / 4), redius * sin(4 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.tealAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(redius * cos(5 * pi / 4), redius * sin(5 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.deepOrange,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(redius * cos(6 * pi / 4), redius * sin(6 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.deepPurple,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(redius * cos(7 * pi / 4), redius * sin(7 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.greenAccent,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(redius * cos(8 * pi / 4), redius * sin(8 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  color: Colors.pink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
      ),
    );
  }
}
