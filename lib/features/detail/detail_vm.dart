import 'package:flutter/material.dart';
import '/pch.dart';
import 'gest.dart';

List<Gest> _gests = [];

final class DetailVm extends ChangeNotifier {
  DetailVm({required this.box, required this.network, this.onSnack, this.onComplete, this.onShowSelect});
  final Box box;
  final Networkable network;
  final void Function(dynamic msg)? onSnack;
  final void Function()? onComplete;
  final Future<List<Gest>?> Function()? onShowSelect;

  void cancel() {
    serialController.dispose();
  }

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
      final res = result.val.checked;
      onSnack?.call(res.message);
      onComplete?.call();
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    } finally {
      deleting = false;
    }
  }

  var _activating = false;
  bool get activating => _activating;
  set activating(bool value) {
    _activating = value;
    notifyListeners();
  }

  final serialController = TextEditingController();
  void serialChanged(String value) {
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
      final res = result.val.checked;
      onSnack?.call(res.message);
      box.status = BoxStatus.activated;
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    } finally {
      activating = false;
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
      final res = result.val.checked;
      onSnack?.call(res.message);
      box.status = BoxStatus.previewed;
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    } finally {
      previewing = false;
    }
  }

  var _generating = false;
  bool get generating => _generating;
  set generating(bool value) {
    _generating = value;
    notifyListeners();
  }

  int? selectedPreview;
  void selectPreview(int index) {
    if (selectedPreview == index) {
      selectedPreview = null;
    } else {
      selectedPreview = index;
    }
    notifyListeners();
  }

  bool get generateEnabled => selectedPreview != null;

  List<Gest> get gests => _gests;

  void generateAction() async {
    print('generating:$_generating, ${_generating ? 'return' : 'continue'}');
    if (_generating) return;
    generating = true;

    try {
      if (box.type == BoxType.human) {
        print('human:true, has-gest:${_gests.isNotEmpty}, ${_gests.isNotEmpty ? 'continue' : 'to-retrive'}');
        if (_gests.isEmpty) {
          final result = await network.reqRes(Api.boxGetGests(), init: Gest.fromApi, key: 'availableActions');
          _gests = result.val.getLst<Gest>() ?? [];
          print('human:true, has-gest:${_gests.isNotEmpty}, ${_gests.isNotEmpty ? 'continue' : 'failed and return'}');
          if (_gests.isEmpty) {
            generating = false;
            return;
          }
        }

        print('human:true, to-select');
        final list = await onShowSelect?.call() ?? [];
        print('human:true, selected-gest:${list.isNotEmpty}, ${list.isNotEmpty ? 'continue' : 'return'}');
        if (list.isEmpty) {
          generating = false;
          return;
        }
      }

      print('to-generate');
      await _generate();
      print('to-generate, done');
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    } finally {
      generating = false;
    }
  }

  Future<void> _generate() async {
    print('_generate');
  }
}
