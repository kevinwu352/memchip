import 'package:flutter/material.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/utils/image_uploader.dart';

final class ChipCreatePetVm extends ChangeNotifier {
  ChipCreatePetVm({required Networkable network}) : _network = network;
  final Networkable _network;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  List<ImageUploader> uploads = [ImageUploader(), ImageUploader()];

  bool? _withTail;
  bool? get withTail => _withTail;
  set withTail(bool? value) {
    _withTail = value;
    notifyListeners();
  }

  void didChooseImage(int index, String path) async {
    uploads[index].launch(path, notifyListeners);
  }
}
