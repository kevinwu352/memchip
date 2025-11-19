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
    _orders.forEach((e) => e.dispose());
    _react?.dispose();
    super.dispose();
  }

  late final _videos = widget.box.videoUrls;

  void _setUp() {
    for (var e in _videos.indexed) {
      if (widget.vdown.statusOf(e.$2.videoUrl) == VDStatus.downloaded) {
        e.$2.path = widget.vdown.pathOf(e.$2.videoUrl);
        print('down: ${e.$1}, downloaded, ${e.$2.path}');
      } else {
        print('down: ${e.$1}, to-download');
        e.$2.path = null;
        widget.vdown.enqueue(e.$2.videoUrl);
      }
    }
    final downs = _videos.indexed.where((e) => e.$2.path == null).map((e) => '${e.$1}');
    print('down: (${downs.join(',')})/${_videos.length}');
    widget.vdown.statusChanged = _downloadChanged;
    widget.vdown.run();
    _startIfPossible();
  }

  void _downloadChanged(VDStatus status, String url) {
    final video = _videos.firstWhereOrNull((e) => e.videoUrl == url);
    if (video != null) {
      if (status == VDStatus.downloaded) {
        video.path = widget.vdown.pathOf(url);
        final downs = _videos.indexed.where((e) => e.$2.path == null).map((e) => '${e.$1}');
        print('down: (${downs.join(',')})/${_videos.length}');
      }
    }
    _startIfPossible();
  }

  void _startIfPossible() async {
    if (_videos.isEmpty) return;
    if (_videos.any((e) => e.path == null)) return;
    print('down: completed, to-play');

    final actions = _videos.where((e) => e.isTouch).toList();
    final normals = _videos.where((e) => !e.isDefault && !e.isTouch).toList();
    final first = _videos.firstWhereOrNull((e) => e.isDefault) ?? normals.firstOrNull;
    if (first == null) return;

    final List<BoxVideo> orders = [];
    if (normals.isEmpty) {
      orders.add(first);
    } else {
      for (var e in normals) {
        orders.add(first);
        orders.add(first);
        orders.add(e);
      }
    }

    List<VideoPlayerController> list = [];
    for (var e in orders.indexed) {
      print('cont: ${e.$1}, begin');
      final cont = VideoPlayerController.file(File(e.$2.path!));
      await cont.initialize();
      cont.addListener(() => _playerChanged(e.$1));
      list.add(cont);
      print('cont: ${e.$1}, end');
    }
    _orders = list;
    _index = 0;
    setState(() {});
    _orders.elementAtOrNull(_index)?.play();
  }

  void _playerChanged(int i) {
    final cont = _orders.elementAtOrNull(i);
    if (cont == null) return;
    print('cont: $i, completed:${cont.value.isCompleted}');
    if (cont.value.isCompleted) {
      if (i == _index) {
        _index = _index + 1 == _orders.length ? 0 : _index + 1;
        print('cont: next $_index');
        setState(() {});
        _orders.elementAtOrNull(_index)?.play();
      } else {
        print('cont: ignore');
      }
    }
  }

  List<VideoPlayerController> _orders = [];
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
            else if (_orders.elementAtOrNull(_index)?.value.isInitialized == true)
              AspectRatio(
                aspectRatio: _orders.elementAtOrNull(_index)!.value.aspectRatio,
                child: VideoPlayer(_orders.elementAtOrNull(_index)!),
              ),

            Text('data: ${widget.box.name}'),
          ],
        ),
      ),
    );
  }
}
