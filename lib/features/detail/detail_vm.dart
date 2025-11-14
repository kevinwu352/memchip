import 'package:flutter/material.dart';
import '/pch.dart';

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
}
