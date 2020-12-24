import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/src/utility/MediaController/CameraCapture.dart';
import 'package:mobile/src/utility/MediaController/VideoCapture.dart';
import 'package:video_player/video_player.dart';

import '../ImagePath.dart';
import '../NavigationUtilities.dart';
import '../Strings.dart';

// ignore: must_be_immutable
class VideoQuickPreview extends StatefulWidget {
  File file;

  VideoQuickPreview(this.file);

  @override
  _VideoQuickPreviewState createState() => _VideoQuickPreviewState();
}

class _VideoQuickPreviewState extends State<VideoQuickPreview> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  ChewieController _chewieController;
  @override
  void initState() {
    if(widget.file.path.contains("http")) {
      _controller = VideoPlayerController.network(
        widget.file.path,
      );
    } else {
      _controller = VideoPlayerController.file(
        widget.file,
      );
    }
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    if(Platform.isAndroid)
      _chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: 2/3,
        // Prepare the video to be played and display the first frame
        autoInitialize: true,
        looping: true,
        // Errors can occur for example when trying to play a video
        // from a non-existent URL
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ); else {
      _controller.play();
      // Use the controller to loop the video.
      _controller.setLooping(true);
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  ],
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    // Use the VideoPlayer widget to display the video.
                    child: Platform.isAndroid ? Chewie(
                      controller: _chewieController,
                    ) : VideoPlayer(_controller),
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
                                context, VideoCapture());
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
                                Strings.REPLACE_VIDEO,
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
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
        floatingActionButton: Visibility (
          visible: Platform.isIOS,
          child: FloatingActionButton(
            onPressed: () {
              // Wrap the play or pause in a call to `setState`. This ensures the
              // correct icon is shown.
              setState(() {
                // If the video is playing, pause it.
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  // If the video is paused, play it.
                  _controller.play();
                }
              });
            },
            // Display the correct icon depending on the state of the player.
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        )
    );
  }
}
