import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/models/create_paras.dart';

final class ChipCreateHumanViewModel extends ChangeNotifier {
  ChipCreateHumanViewModel({required Networkable network}) : _network = network {
    for (var element in uploads) {
      element.notify = notifyListeners;
    }
  }
  final Networkable _network;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  List<ImageUploader> uploads = [ImageUploader()];

  void didChooseImage(int index, String path) async {
    final item = uploads[index];
    if (item.path != path) {
      item.reset();
      item.path = path;
      notifyListeners();
      // getUploadParas(index, path);
      item.getUploadParas(index, path);
    }
  }
}

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

  void getUploadParas(int index, String path) async {
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
        final paras = CreateParas.fromApi(json);
        // print('upload: paras success');
        uploadImage(index, path, paras);
      } else {
        throw HttpError.status;
      }
    } catch (e) {
      // final err = e is HttpError ? e : HttpError.unknown;
      // snackPub.value = err;
      print('upload: paras failed');

      uploading = false;
      success = false;
      notify?.call();
    }
  }

  void uploadImage(int index, String path, CreateParas paras) async {
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
        print('upload: upload success ${paras.url}');
        notify?.call();
      } else {
        throw HttpError.status;
      }
    } catch (e) {
      print('upload: upload failed ${paras.url}');

      uploading = false;
      success = false;
      notify?.call();
    }
  }
}
