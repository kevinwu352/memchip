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
    // _videos = [
    //   // widget.box.videoUrls[0],
    //   widget.box.videoUrls[1],
    //   widget.box.videoUrls[2],
    //   widget.box.videoUrls[3],
    // ];
    _setUp();
  }

  @override
  void dispose() {
    widget.vdown.statusChanged = null;
    _normals.forEach((e) => e.dispose());
    _actions.forEach((e) => e.dispose());
    super.dispose();
  }

  late final _videos = widget.box.videoUrls;
  // late List<BoxVideo> _videos;

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

    final List<BoxVideo> ordered = [first, ...normals];
    // final List<BoxVideo> ordered = [];
    // if (normals.isEmpty) {
    //   ordered.add(first);
    // } else {
    //   for (var e in normals) {
    //     // ordered.add(first);
    //     ordered.add(first);
    //     ordered.add(e);
    //   }
    // }

    List<VideoPlayerController> list1 = [];
    for (var e in actions.indexed) {
      // print('cont: ${e.$1}, begin');
      final cont = VideoPlayerController.file(File(e.$2.path!));
      await cont.initialize();
      cont.addListener(() => _actionUpdated(e.$1));
      list1.add(cont);
      // print('cont: ${e.$1}, end');
    }
    _actions = list1;

    List<VideoPlayerController> list2 = [];
    for (var e in ordered.indexed) {
      // print('cont: ${e.$1}, begin');
      final cont = VideoPlayerController.file(File(e.$2.path!));
      await cont.initialize();
      cont.addListener(() => _normalUpdated(e.$1));
      list2.add(cont);
      // print('cont: ${e.$1}, end');
    }
    _normals = list2;
    _ni = 0;
    setState(() {});
    _normals.elementAtOrNull(_ni)?.play();
  }

  void _normalUpdated(int i) {
    final cont = _normals.elementAtOrNull(i);
    if (cont == null) return;
    if (!cont.value.isCompleted) return;
    if (i == _ni) {
      _ni = _ni + 1 == _normals.length ? 0 : _ni + 1;
      if (_pending != null) {
        _ai = _pending;
        _pending = null;
      } else {
        _ai = null;
      }
      print('norm: next [$_ni, $_ai]');
      setState(() {});
      if (_ai != null) {
        _actions.elementAtOrNull(_ai!)?.play();
      } else {
        _normals.elementAtOrNull(_ni)?.play();
      }
    } else {
      print('norm: ignore');
    }
  }

  void _actionUpdated(int i) {
    final cont = _actions.elementAtOrNull(i);
    if (cont == null) return;
    if (!cont.value.isCompleted) return;
    if (i == _ai) {
      // _ni =
      if (_pending != null) {
        _ai = _pending;
        _pending = null;
      } else {
        _ai = null;
      }
      print('actn: next [$_ni, $_ai]');
      setState(() {});
      if (_ai != null) {
        _actions.elementAtOrNull(_ai!)?.play();
      } else {
        _normals.elementAtOrNull(_ni)?.play();
      }
    } else {
      print('actn: ignore');
    }
  }

  List<VideoPlayerController> _normals = [];
  int _ni = 0;
  List<VideoPlayerController> _actions = [];
  int? _ai;
  int? _pending;

  @override
  Widget build(BuildContext context) {
    print('reload');
    return Scaffold(
      body: SizedBox.expand(
        child: GestureDetector(
          onTap: () {
            // if (_ai == null) {
            //   print('tapped, next play action');
            //   _pending = 0;
            // } else {
            //   print('tapped, next play normal');
            // }
            print('tapped, next play action');
            _pending = 0;
          },
          child: Stack(
            children: [
              if (_ai != null && _actions[_ai!].value.isInitialized)
                AspectRatio(aspectRatio: _actions[_ai!].value.aspectRatio, child: VideoPlayer(_actions[_ai!]))
              else if (_normals.elementAtOrNull(_ni)?.value.isInitialized == true)
                AspectRatio(aspectRatio: _normals[_ni].value.aspectRatio, child: VideoPlayer(_normals[_ni])),
            ],
          ),
        ),
      ),
    );
  }
}
