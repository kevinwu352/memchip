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

  void _startIfPossible() async {
    final completed = _videos.every((e) => e.path is String);
    if (completed) {
      print('play-down: completed, to-play');

      List<VideoPlayerController> list = [];
      for (var e in _videos.indexed) {
        print('play-cret: ${e.$1}, begin');
        final c = VideoPlayerController.file(File(e.$2.path!));
        c.addListener(() {
          print('completed: ${e.$1} ${c.value.isCompleted}');
          if (c.value.isCompleted) {
            if (_index == e.$1) {
              _index = _index == 3 ? 0 : _index + 1;
              setState(() {});
              _normals.elementAtOrNull(_index)?.play();
            }
          }
        });
        await c.initialize();
        list.add(c);
        print('play-cret: ${e.$1}, end');
      }
      _normals = list;
      // _orders = [0, 0, 1, 0, 0, 2, 0, 0, 3];
      _orders = [0, 1, 2, 3];
      _index = 0;
      setState(() {});
      _normals.elementAtOrNull(_index)?.play();
    }
  }

  List<VideoPlayerController> _normals = [];
  List<int> _orders = [];
  int _index = 0;

  VideoPlayerController? _react;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            if (_react?.value.isInitialized == true)
              AspectRatio(aspectRatio: _react!.value.aspectRatio, child: VideoPlayer(_react!))
            else if (_orders.elementAtOrNull(_index) != null &&
                _normals.elementAtOrNull(_orders[_index])?.value.isInitialized == true)
              AspectRatio(
                aspectRatio: _normals.elementAtOrNull(_orders[_index])!.value.aspectRatio,
                child: VideoPlayer(_normals.elementAtOrNull(_orders[_index])!),
              ),

            Text('data: ${widget.box.name}'),
          ],
        ),
      ),
    );
  }
}
