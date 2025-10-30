import 'package:flutter/material.dart';
import '/network/network.dart';

final class ChipCreateHumanViewModel extends ChangeNotifier {
  ChipCreateHumanViewModel({required Networkable network}) : _network = network;
  final Networkable _network;

  // ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  List<UploadImage> uploads = [UploadImage()];
  void didChooseImage(int index, String path) {
    uploads[index].path = path;
    notifyListeners();
  }
}

class UploadImage {
  String? path;
  String? url;
}
