import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:export_video_frame/export_video_frame.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  File file;
  VideoPreview(this.file) : super();

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  ChewieController _chewieController;
  @override
  void initState() {
    _controller = VideoPlayerController.file(
      widget.file,
    );
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
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    if(Platform.isAndroid) _chewieController.dispose();
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
                  color: Colors.black,
                  padding: EdgeInsets.only(right: 20),
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
                              finish(context);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
      )  // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void finish(BuildContext context) async {
    if (Platform.isAndroid) {
      final videoThumbnail = await Thumbnails.getThumbnail(
          thumbnailFolder:
          join((await getTemporaryDirectory()).path, 'Thumbnails'),
          videoFile: widget.file.path,
          imageType: ThumbFormat.PNG,
          quality: 30);
      Navigator.pop(context, 'ok'+videoThumbnail);
    } else {
      var duration = Duration(seconds: 1);
      var image = await ExportVideoFrame.exportImageBySeconds(widget.file, duration, 0);
      Navigator.pop(context, 'ok' + image.path);
    }

  }

}


