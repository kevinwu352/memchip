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
      // await Future.delayed(Duration(seconds: 60));
      final result = await network.reqRes(Api.boxDelete(id));
      deleting = false;
      switch (result) {
        case Ok():
          final res = result.value;
          if (res.success) {
            onSnack?.call(res.message);
            onComplete?.call();
          } else {
            throw HttpError.operation;
          }
        case Error():
          throw result.error;
      }
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    }
  }
}
