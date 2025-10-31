import 'package:flutter/material.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/utils/image_uploader.dart';

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
      item.getUploadParas(path);
    }
  }
}
