import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'CameraPreview.dart' as Preview;

// ignore: must_be_immutable
class CameraCapture extends StatefulWidget {
  CameraCapture();

  @override
  _CameraCaptureState createState() => _CameraCaptureState();
}

class _CameraCaptureState extends State<CameraCapture> {
  CameraController controller;

  CameraController _controller;
  Future<void> _initializeControllerFuture;
  var isCameraReady = false;
  var showCapturedPhoto = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera is disposed, so we need to call again "issue is only for android"
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          return new Scaffold(
            backgroundColor: Colors.black,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: CameraPreview(_controller), //cameraPreview
                ),
                Visibility(
                  visible: showCapturedPhoto,
                  child: Container(
                      width: double.infinity,
                      height: 70,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
                        iconSize: 50,
                        onPressed: () {
                          onCaptureButtonPressed((String imagePath) {
                            navigateToCameraPreview(context, imagePath);
                          });
                        },
                      )),
                )
              ],
            ),
          );
        });
  }

  void navigateToCameraPreview(BuildContext context, String imagePath) async {
    final result = await NavigatorUtilities.push(
        context, Preview.CameraPreview(File(imagePath)));
    if (result == 'ok') Navigator.pop(context, imagePath);
  }

  void onCaptureButtonPressed(Function cbSuccess) async {
    showCapturedPhoto = false;
    try {
      String imagePath = '';
      imagePath = join(
        (await getTemporaryDirectory()).path, //Temporary path
        'images-${DateTime.now()}.png',
      );
      await _controller.takePicture(imagePath);
      setState(() {
        showCapturedPhoto = true;
      });
      cbSuccess(imagePath);
    } catch (e) {
      showCapturedPhoto = true;
      print(e);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
