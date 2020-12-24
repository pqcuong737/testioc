import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';

class SkelentonText extends StatefulWidget {
  SkelentonText({Key key}) : super(key: key);

  @override
  _SkelentonTextState createState() => _SkelentonTextState();
}

class _SkelentonTextState extends State<SkelentonText> {
  @override
  Widget build(BuildContext context) {
    return ListSkeleton(
      style: SkeletonStyle(
        theme: SkeletonTheme.Light,
        isShowAvatar: false,
        barCount: 1,
        colors: [Color(0xff333333), Color(0xffffff45), Color(0xff333333)],
        isAnimation: true,
      ),
    );
  }
}
