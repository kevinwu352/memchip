import 'package:flutter/material.dart';
import '/pch.dart';

List<Gest> _gests = [];

final class DetailVm extends ChangeNotifier {
  DetailVm({required this.box, required this.network, this.onSnack, this.onComplete, this.onSelectGest});
  final Box box;
  final Networkable network;
  final void Function(dynamic msg)? onSnack;
  final void Function()? onComplete;
  final Future<bool?> Function()? onSelectGest;

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

  var _generating = false;
  bool get generating => _generating;
  set generating(bool value) {
    _generating = value;
    notifyListeners();
  }

  int? selectedPreview;
  void selectAction(int index) {
    if (selectedPreview == index) {
      selectedPreview = null;
    } else {
      selectedPreview = index;
    }
    notifyListeners();
  }

  bool get generateEnabled => selectedPreview != null;

  void generateAction() async {
    if (_generating) {
      print('generating:yes, return');
      return;
    } else {
      print('generating:no, continue');
    }
    generating = true;

    if (box.isHuman) {
      if (_gests.isEmpty) {
        print('human:yes, has-gest:no, to-retrive');
        await _getGests();
        if (_gests.isEmpty) {
          print('human:yes, has-gest:no, to-retrive, got:${_gests.length}, return');
          generating = false;
          return;
        } else {
          print('human:yes, has-gest:no, to-retrive, got:${_gests.length}, continue');
        }
      } else {
        print('human:yes, has-gest:yes, continue');
      }

      print('human:yes, to-select');
      final confirmed = await onSelectGest?.call();
      if (confirmed == true) {
        print('human:yes, to-select, got:$confirmed, continue');
      } else {
        print('human:yes, to-select, got:$confirmed, return');
        generating = false;
        return;
      }
    }

    print('to-generate');
    await _generate();
    print('to-generate, done');
    _generating = false;
  }

  Future<void> _getGests() async {
    try {
      final result = await network.reqRes(Api.boxGetGests(), init: Gest.fromApi, key: 'availableActions');
      final list = result.val.getLst<Gest>();
      _gests = list ?? [];
    } catch (e) {}
  }

  List<Gest> get gests => _gests;

  Future<void> _generate() async {
    print('_generate');
  }
}
