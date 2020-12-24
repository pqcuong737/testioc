import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
class LoadingStypeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingJumpingLine.circle(
          borderColor: Colors.cyan,
          borderSize: 3.0,
          size: 40.0,
          backgroundColor: Colors.blue,
          duration: Duration(milliseconds: 600),
        ));
  }
}
