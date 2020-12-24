import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class PreviewImgFull extends StatefulWidget {
  final String url;
  PreviewImgFull(this.url);
  @override
  _PreviewImgFullState createState() => _PreviewImgFullState();
}

class _PreviewImgFullState extends State<PreviewImgFull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Stack(
                children: <Widget>[
                  PhotoView(
                    imageProvider: NetworkImage("${widget.url}"),
                  ),
                  Positioned(
                    top: 50.0,
                    left: 20.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(5),
                          child: Icon(Icons.close),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
