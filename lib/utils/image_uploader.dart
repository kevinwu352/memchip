import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import '/network/network.dart';

class ImageUploader {
  String? path;
  String? url;
  bool uploading = false;
  bool? success;
  void Function()? notify;

  void reset() {
    path = null;
    url = null;
    uploading = false;
    success = null;
  }

  void launch(String path, void Function() notify) {
    if (this.path == path) return;
    reset();
    this.path = path;
    this.notify = notify;
    _getUploadParas(path);
  }

  void _getUploadParas(String path) async {
    try {
      uploading = true;
      notify?.call();

      final name = 'upload/${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(100000)}.png';
      final uri = Uri(
        scheme: 'https',
        host: kCurrentHost,
        path: '/http/ext-storage-co/getUploadFileOptions',
        queryParameters: {'cloudPath': Uri.encodeComponent(name)},
      );
      final response = await get(uri).timeout(Duration(seconds: 15));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final paras = _Paras.fromApi(json);
        // print('upload: paras success');
        _uploadImage(path, paras);
      } else {
        throw HttpError.status;
      }
    } catch (e) {
      // print('upload: paras failed');
      uploading = false;
      success = false;
      notify?.call();
    }
  }

  void _uploadImage(String path, _Paras paras) async {
    try {
      var request = MultipartRequest('POST', Uri.parse(paras.server));
      request.fields['token'] = paras.token;
      request.fields['key'] = paras.key;
      request.files.add(await MultipartFile.fromPath('file', path));

      var response = await request.send();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        url = paras.url;
        uploading = false;
        success = true;
        // print('upload: upload success ${paras.url}');
        notify?.call();
      } else {
        throw HttpError.status;
      }
    } catch (e) {
      // print('upload: upload failed ${paras.url}');
      uploading = false;
      success = false;
      notify?.call();
    }
  }
}

class _Paras {
  String server;
  String token;
  String key;
  String url;

  _Paras({required this.server, required this.token, required this.key, required this.url});

  factory _Paras.fromApi(Map<String, dynamic> json) {
    final url = json['fileURL'] as String;

    final options = json['uploadFileOptions'] as Map;
    final server = options['url'] as String;

    final data = options['formData'] as Map;
    final token = data['token'] as String;
    final key = data['key'] as String;

    return _Paras(server: server, token: token, key: key, url: url);
  }
}
