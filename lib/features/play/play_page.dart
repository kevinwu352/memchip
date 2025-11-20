import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    //   widget.box.videoUrls[0],
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

  bool _preparing = true;

  // bool _showAlert = true;

  late final _videos = widget.box.videoUrls;
  // late List<BoxVideo> _videos;

  void _setUp() {
    _preparing = true;
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

    // final ordered = [first, ...normals];
    final List<BoxVideo> ordered = [];
    if (normals.isEmpty) {
      ordered.add(first); // to solve player complete twice problem
      ordered.add(first);
    } else {
      for (var e in normals) {
        // ordered.add(first);
        ordered.add(first);
        ordered.add(e);
      }
    }
    List<VideoPlayerController> list1 = [];
    for (var e in ordered.indexed) {
      // print('cont: ${e.$1}, begin');
      final cont = VideoPlayerController.file(File(e.$2.path!));
      await cont.initialize();
      cont.addListener(() => _normalUpdated(e.$1));
      list1.add(cont);
      // print('cont: ${e.$1}, end');
    }
    _normals = list1;
    _ni = 0;

    final List<BoxVideo> doubled = []; // to solve player complete twice problem
    for (var e in actions) {
      doubled.add(e);
      doubled.add(e);
    }
    final List<VideoPlayerController> list2 = [];
    for (var e in doubled.indexed) {
      // print('cont: ${e.$1}, begin');
      final cont = VideoPlayerController.file(File(e.$2.path!));
      await cont.initialize();
      cont.addListener(() => _actionUpdated(e.$1));
      list2.add(cont);
      // print('cont: ${e.$1}, end');
    }
    _actions = list2;
    _ai = null;

    _preparing = false;
    _controller = _normals.elementAtOrNull(_ni);
    setState(() {});
    _controller?.play();
  }

  void _normalUpdated(int i) {
    final cont = _normals.elementAtOrNull(i);
    if (cont == null) return;
    if (!cont.value.isCompleted) return;
    if (i == _ni) {
      print('norm: completed $i==$_ni, next');
      _ni = _ni + 1 == _normals.length ? 0 : _ni + 1;
      _loadAction();
      _loadController();
      print('norm: next [$_ni, $_ai]');
      setState(() {});
      _controller?.play();
    } else {
      print('norm: completed $i!=$_ni, ignore');
    }
  }

  void _actionUpdated(int i) {
    final cont = _actions.elementAtOrNull(i);
    if (cont == null) return;
    if (!cont.value.isCompleted) return;
    if (i == _ai) {
      print('actn: completed $i==$_ai, next');
      // _ni =
      _loadAction();
      _loadController();
      print('actn: next [$_ni, $_ai]');
      setState(() {});
      _controller?.play();
    } else {
      print('actn: completed $i!=$_ai, ignore');
    }
  }

  void _loadAction() {
    if (_pending != null) {
      _ai = _pending;
      _pending = null;
    } else {
      _ai = null;
    }
  }

  void _loadController() {
    if (_ai != null) {
      _controller = _actions.elementAtOrNull(_ai!);
    } else {
      _controller = _normals.elementAtOrNull(_ni);
    }
  }

  VideoPlayerController? _controller;

  List<VideoPlayerController> _normals = [];
  int _ni = 0;
  List<VideoPlayerController> _actions = [];
  int? _ai;
  int? _pending;

  void _actionTapped(int i) {
    int? n;
    int count = _videos.where((e) => e.isTouch).length;
    if (count == 1) {
      n = 0;
    } else if (count == 2) {
      switch (i) {
        case 0:
        case 1:
          n = 0;
        case 2:
        case 3:
          n = 1;
      }
    } else if (count == 3) {
      switch (i) {
        case 0:
        case 1:
          n = 0;
        case 2:
          n = 1;
        case 3:
          n = 2;
      }
    } else if (count >= 4) {
      switch (i) {
        case 0:
          n = 0;
        case 1:
          n = 1;
        case 2:
          n = 2;
        case 3:
          n = 3;
      }
    }
    if (n != null) {
      final m = n * 2;
      _pending = _ai == m ? m + 1 : m;
      print('tapped:$i, action: $n,$_pending');
    } else {
      print('tapped:$i, action: $n');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_preparing) CircularProgressIndicator.adaptive(backgroundColor: MyColors.white100),

            if (_controller != null)
              AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: VideoPlayer(_controller!)),
            if (_controller != null) _ActionView(onTapped: _actionTapped),

            Positioned(
              left: 10,
              top: 65,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.adaptive.arrow_back),
                color: MyColors.white100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionView extends StatelessWidget {
  const _ActionView({required this.onTapped});
  final void Function(int i) onTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onTapped(0),
                  // child: Container(color: Colors.red),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTapped(1),
                  // child: Container(color: Colors.green),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onTapped(2),
                  // child: Container(color: Colors.blue),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTapped(3),
                  // child: Container(color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
