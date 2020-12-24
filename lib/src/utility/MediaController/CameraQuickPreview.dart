import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/src/route.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/MediaController/CameraCapture.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';

// ignore: must_be_immutable
class ImagePreview extends StatefulWidget {
  File file;

  ImagePreview(this.file);

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  ImagePath.ic_close,
                  width: 30,
                  height: 30,
                )),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
          Expanded(
            child: Center(
              child: widget.file.path.contains('images-')
                  ? Image.file(widget.file)
                  : Image.network(widget.file.path, fit: BoxFit.contain),
            ),
          ),
          Container(
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      final result = await NavigatorUtilities.push(
                          context, CameraCapture());
                      Navigator.pop(context, result);
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                            color: Colors.white,
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          Strings.REPLACE_IMAGE,
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: 50,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        iconSize: 25,
                        onPressed: () {
                          //delete Image
                          setState(() {
                            Navigator.pop(context, 'delete');
                          });
                        },
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
