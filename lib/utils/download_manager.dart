import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '/core/core.dart';

enum DownloadStatus { unknown, downloading, waiting, downloaded, failed }

class DownloadManager extends ChangeNotifier {
  Future<void> init() async {
    final path = pathmk('downloads');
    await direCreate(path);
  }

  void enqueue(String url) {
    final status = statusOf(url);
    if (kDebugMode) debugPrint('enqueue: $url, ${status.name}');
    switch (status) {
      case DownloadStatus.unknown:
        statusChanged?.call(DownloadStatus.unknown, url);
        _queue.insert(0, url);
        statusChanged?.call(DownloadStatus.waiting, url);
      case DownloadStatus.downloading:
        statusChanged?.call(DownloadStatus.downloading, url);
      case DownloadStatus.waiting:
        _queue.remove(url);
        _queue.insert(0, url);
        statusChanged?.call(DownloadStatus.waiting, url);
      case DownloadStatus.downloaded:
        statusChanged?.call(DownloadStatus.downloaded, url);
      case DownloadStatus.failed:
        break;
    }
  }

  void run() async {
    if (kDebugMode) debugPrint('run: queue:${_queue.length}, ongoing:$_ongoing');
    if (_ongoing != null || _queue.isEmpty) return;

    String url = _queue.removeAt(0);
    if (kDebugMode) debugPrint('run: start, $url');
    _ongoing = url;
    statusChanged?.call(DownloadStatus.downloading, url);

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
      statusChanged?.call(response.statusCode == 200 ? DownloadStatus.downloaded : DownloadStatus.failed, url);
    } catch (e) {
      statusChanged?.call(DownloadStatus.failed, url);
    }

    _ongoing = null;
    run();
  }

  final List<String> _queue = [];
  String? _ongoing;
  void Function(DownloadStatus, String)? statusChanged;

  DownloadStatus statusOf(String url) {
    if (_ongoing == url) {
      return DownloadStatus.downloading;
    } else if (_queue.contains(url)) {
      return DownloadStatus.waiting;
    } else if (fileExistSync(pathOf(url))) {
      return DownloadStatus.downloaded;
    }
    return DownloadStatus.unknown;
  }

  String pathOf(String url) => pathmk('downloads', '${url.md5}.mp4');
}
