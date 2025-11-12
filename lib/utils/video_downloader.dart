import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '/core/core.dart';

enum Statu { unknown, downloading, waiting, downloaded, failed }

class VideoDownloader extends ChangeNotifier {
  Future<void> init() async {
    final path = pathmk('downloads');
    await direCreate(path);
  }

  void enqueue(String url) {
    final statu = statuOf(url);
    if (kDebugMode) debugPrint('enqueue: $url, ${statu.name}');
    switch (statu) {
      case Statu.unknown:
        statuChanged?.call(Statu.unknown, url);
        _queue.insert(0, url);
        statuChanged?.call(Statu.waiting, url);
      case Statu.downloading:
        statuChanged?.call(Statu.downloading, url);
      case Statu.waiting:
        _queue.remove(url);
        _queue.insert(0, url);
        statuChanged?.call(Statu.waiting, url);
      case Statu.downloaded:
        statuChanged?.call(Statu.downloaded, url);
      case Statu.failed:
        break;
    }
  }

  void run() async {
    if (kDebugMode) debugPrint('run: queue:${_queue.length}, ongoing:$_ongoing');
    if (_ongoing != null || _queue.isEmpty) return;

    String url = _queue.removeAt(0);
    if (kDebugMode) debugPrint('run: start, $url');
    _ongoing = url;
    statuChanged?.call(Statu.downloading, url);

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
      statuChanged?.call(response.statusCode == 200 ? Statu.downloaded : Statu.failed, url);
    } catch (e) {
      statuChanged?.call(Statu.failed, url);
    }

    _ongoing = null;
    run();
  }

  final List<String> _queue = [];
  String? _ongoing;
  void Function(Statu, String)? statuChanged;

  Statu statuOf(String url) {
    if (_ongoing == url) {
      return Statu.downloading;
    } else if (_queue.contains(url)) {
      return Statu.waiting;
    } else if (fileExistSync(pathOf(url))) {
      return Statu.downloaded;
    }
    return Statu.unknown;
  }

  String pathOf(String url) => pathmk('downloads', '${url.md5}.mp4');
}
