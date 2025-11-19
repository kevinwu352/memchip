import 'package:flutter/material.dart';
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

  late final videos = widget.box.videoUrls;

  void _setUp() {
    for (var e in videos.indexed) {
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
      'play-down: (${videos.where((e) => e.path == null).indexed.map((e) => '${e.$1}').join(',')})/${videos.length}',
    );
    widget.vdown.statusChanged = _downloadChanged;
    widget.vdown.run();
    _startIfPossible();
  }

  void _downloadChanged(VDStatus status, String url) {
    final video = videos.firstWhereOrNull((e) => e.videoUrl == url);
    if (video != null) {
      if (status == VDStatus.downloaded) {
        video.path = widget.vdown.pathOf(url);
        print(
          'play-down: (${videos.where((e) => e.path == null).indexed.map((e) => '${e.$1}').join(',')})/${videos.length}',
        );
      }
    }
    _startIfPossible();
  }

  void _startIfPossible() {
    final completed = videos.every((e) => e.path is String);
    if (completed) {
      print('play-down: completed, to-play');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //
          Text('data: ${widget.box.name}'),
        ],
      ),
    );
  }
}
