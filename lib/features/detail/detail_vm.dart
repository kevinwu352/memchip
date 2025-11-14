import 'package:flutter/material.dart';
import '/pch.dart';

List<Gest> _gests = [];

final class DetailVm extends ChangeNotifier {
  DetailVm({required this.box, required this.network, this.onSnack, this.onComplete});
  final Box box;
  final Networkable network;
  final void Function(dynamic msg)? onSnack;
  final void Function()? onComplete;

  var _deleting = false;
  bool get deleting => _deleting;
  set deleting(bool value) {
    _deleting = value;
    notifyListeners();
  }

  void deleteAction() {
    if (_deleting) return;
    _delete(box.id);
  }

  void _delete(String id) async {
    try {
      deleting = true;
      final result = await network.reqRes(Api.boxDelete(id));
      deleting = false;
      final res = result.val.checked;
      onSnack?.call(res.message);
      onComplete?.call();
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    }
  }

  final serialController = TextEditingController();
  void serialChanged(String value) {
    notifyListeners();
  }

  var _activating = false;
  bool get activating => _activating;
  set activating(bool value) {
    _activating = value;
    notifyListeners();
  }

  void activateAction() {
    if (_activating) return;
    if (serialController.text.isEmpty) return;
    _activate(box.id, serialController.text);
  }

  void _activate(String id, String code) async {
    try {
      activating = true;
      final result = await network.reqRes(Api.boxActivate(id, code));
      activating = false;
      final res = result.val.checked;
      onSnack?.call(res.message);
      box.status = BoxStatus.activated;
      notifyListeners();
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    }
  }

  var _previewing = false;
  bool get previewing => _previewing;
  set previewing(bool value) {
    _previewing = value;
    notifyListeners();
  }

  void previewAction() {
    if (_previewing) return;
    _preview(box.id);
  }

  void _preview(String id) async {
    try {
      previewing = true;
      final result = await network.reqRes(Api.boxPreview(id));
      previewing = false;
      final res = result.val.checked;
      onSnack?.call(res.message);
      box.status = BoxStatus.previewed;
      notifyListeners();
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    }
  }

  List<int> selected = [];
  void selectAction(int index) {
    if (selected.contains(index)) {
      selected.remove(index);
    } else {
      selected.add(index);
    }
    notifyListeners();
  }

  var _generating = false;
  bool get generating => _generating;
  set generating(bool value) {
    _generating = value;
    notifyListeners();
  }

  void generateAction() {
    if (_generating) return;
    if (_gests.isEmpty) {
      _getGests();
    } else {
      _generate();
    }
  }

  void _getGests() async {
    try {
      final result = await network.reqRes(Api.boxGetGests(), init: Gest.fromApi, key: 'availableActions');
      final list = result.val.getLst<Gest>();
      _gests = list ?? [];
    } catch (e) {
      // final err = e is HttpError ? e : HttpError.unknown;
      // onSnack?.call(err);
    }
  }

  void _generate() {}
}
