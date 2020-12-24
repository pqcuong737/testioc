import 'package:flutter/material.dart';
import 'package:mobile/src/app/pages/profile/view/preview_full_image.view.dart';
import 'package:mobile/src/utility/ImagePath.dart';

class ImgView extends StatefulWidget {
  final url;

  ImgView(this.url);

  @override
  _ImgViewState createState() => _ImgViewState();
}

class _ImgViewState extends State<ImgView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: widget.url != null
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewImgFull(widget.url),
                    ),
                  );
                },
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      widget.url,
                      width: 115,
                      height: 115,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : InkWell(
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      ImagePath.thumb,
                      width: 115,
                      height: 115,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ));
  }
}
