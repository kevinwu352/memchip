import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '/pch.dart';
import '/utils/video_downloader.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key, required this.box, required this.vdown});
  final Box box;
  final VideoDownloader vdown;

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  @override
  void initState() {
    super.initState();
    _setUp();
  }

  @override
  void dispose() {
    widget.vdown.statusChanged = null;
    super.dispose();
  }

  late final _videos = widget.box.videoUrls;

  void _setUp() {
    for (var e in _videos.indexed) {
      if (widget.vdown.statusOf(e.$2.videoUrl) == VDStatus.downloaded) {
        print('play-down: ${e.$1}, downloaded');
        e.$2.path = widget.vdown.pathOf(e.$2.videoUrl);
      } else {
        print('play-down: ${e.$1}, to-download');
        e.$2.path = null;
        widget.vdown.enqueue(e.$2.videoUrl);
      }
    }
    print(
      'play-down: (${_videos.where((e) => e.path == null).indexed.map((e) => '${e.$1}').join(',')})/${_videos.length}',
    );
    widget.vdown.statusChanged = _downloadChanged;
    widget.vdown.run();
    _startIfPossible();
  }

  void _downloadChanged(VDStatus status, String url) {
    final video = _videos.firstWhereOrNull((e) => e.videoUrl == url);
    if (video != null) {
      if (status == VDStatus.downloaded) {
        video.path = widget.vdown.pathOf(url);
        print(
          'play-down: (${_videos.where((e) => e.path == null).indexed.map((e) => '${e.$1}').join(',')})/${_videos.length}',
        );
      }
    }
    _startIfPossible();
  }

  void _startIfPossible() {
    final completed = _videos.every((e) => e.path is String);
    if (completed) {
      print('play-down: completed, to-play');

      _controller = VideoPlayerController.file(File(_videos[0].path!))
        ..initialize().then((_) {
          print('bbb');
          // _controller.play();
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
      print('aaa');
      _controller.play();
    }
  }

  late VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //
          if (_controller.value.isInitialized)
            AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)),

          Text('data: ${widget.box.name}'),
        ],
      ),
    );
  }
}
