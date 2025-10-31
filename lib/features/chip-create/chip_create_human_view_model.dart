import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/utils/api.dart';
import '/models/create_paras.dart';

final class ChipCreateHumanViewModel extends ChangeNotifier {
  ChipCreateHumanViewModel({required Networkable network}) : _network = network;
  final Networkable _network;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  List<UploadImage> uploads = [UploadImage()];

  void didChooseImage(int index, String path) async {
    final item = uploads[index];
    if (item.path != path) {
      item.reset();
      item.path = path;
      notifyListeners();
      getUploadParas(index, path);
    }
  }

  void getUploadParas(int index, String path) async {
    try {
      uploads[index].uploading = true;
      notifyListeners();

      final name = 'upload/${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(10000)}.png';
      final result = await _network.reqRes(Api.createGetUploadParas(name), CreateParas.fromApi);
      switch (result) {
        case Ok():
          final res = result.value;
          final paras = res.getObject<CreateParas>();
          if (paras != null) {
            // print('upload: paras success');
            uploadImage(index, path, paras);
          } else {
            throw HttpError.operation;
          }
        case Error():
          throw result.error;
      }
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      snackPub.value = err;
      // print('upload: paras failed');

      uploads[index].uploading = false;
      uploads[index].success = false;
      notifyListeners();
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
        uploads[index].url = paras.url;
        uploads[index].uploading = false;
        uploads[index].success = true;
        // print('upload: upload success ${paras.url}');
        notifyListeners();
      } else {
        throw HttpError.status;
      }
    } catch (e) {
      // print('upload: upload failed ${paras.url}');

      uploads[index].uploading = false;
      uploads[index].success = false;
      notifyListeners();
    }
  }
}

class UploadImage {
  String? path;
  String? url;
  bool uploading = false;
  bool? success;
  void reset() {
    path = null;
    url = null;
    uploading = false;
    success = null;
  }
}
