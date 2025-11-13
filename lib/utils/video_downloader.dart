import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '/core/core.dart';

enum VDStatus { unknown, downloading, waiting, downloaded, failed }

class VideoDownloader extends ChangeNotifier {
  Future<void> init() async {
    final path = pathmk('downloads');
    await direCreate(path);
  }

  void enqueue(String url) {
    final status = statusOf(url);
    if (kDebugMode) debugPrint('enqueue: $url, ${status.name}');
    switch (status) {
      case VDStatus.unknown:
        statusChanged?.call(VDStatus.unknown, url);
        _queue.insert(0, url);
        statusChanged?.call(VDStatus.waiting, url);
      case VDStatus.downloading:
        statusChanged?.call(VDStatus.downloading, url);
      case VDStatus.waiting:
        _queue.remove(url);
        _queue.insert(0, url);
        statusChanged?.call(VDStatus.waiting, url);
      case VDStatus.downloaded:
        statusChanged?.call(VDStatus.downloaded, url);
      case VDStatus.failed:
        break;
    }
  }

  void run() async {
    if (kDebugMode) debugPrint('run: queue:${_queue.length}, ongoing:$_ongoing');
    if (_ongoing != null || _queue.isEmpty) return;

    String url = _queue.removeAt(0);
    if (kDebugMode) debugPrint('run: start, $url');
    _ongoing = url;
    statusChanged?.call(VDStatus.downloading, url);

    try {
      final uri = Uri.parse(url);
      final response = await get(uri).timeout(Duration(seconds: 15));
      if (response.statusCode == 200) {
        if (kDebugMode) debugPrint('run: success, $url');
        final file = File(pathOf(url));
        await file.writeAsBytes(response.bodyBytes);
      } else {
        if (kDebugMode) debugPrint('run: failed, $url, ${response.statusCode}');
      }
      statusChanged?.call(response.statusCode == 200 ? VDStatus.downloaded : VDStatus.failed, url);
    } catch (e) {
      statusChanged?.call(VDStatus.failed, url);
    }

    _ongoing = null;
    run();
  }

  final List<String> _queue = [];
  String? _ongoing;
  void Function(VDStatus, String)? statusChanged;

  VDStatus statusOf(String url) {
    if (_ongoing == url) {
      return VDStatus.downloading;
    } else if (_queue.contains(url)) {
      return VDStatus.waiting;
    } else if (fileExistSync(pathOf(url))) {
      return VDStatus.downloaded;
    }
    return VDStatus.unknown;
  }

  String pathOf(String url) => pathmk('downloads', '${url.md5}.mp4');
}
