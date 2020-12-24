import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/src/route.dart';

// ignore: must_be_immutable
class CameraPreview extends StatefulWidget {
  File file;
  CameraPreview(this.file);
  @override
  _CameraPreviewState createState() => _CameraPreviewState();
}

class _CameraPreviewState extends State<CameraPreview> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Image.file(widget.file),
          ),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.undo),
                      color: Colors.white,
                      iconSize: 50,
                      onPressed: () {
                        widget.file.deleteSync();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.done),
                      color: Colors.white,
                      iconSize: 50,
                      onPressed: () {
                        Navigator.pop(context, 'ok');
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
