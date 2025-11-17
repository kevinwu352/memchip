import 'package:flutter/material.dart';
import '/pch.dart';

final class HomeVm extends ChangeNotifier {
  HomeVm({required this.network});
  final Networkable network;

  List<Box> _boxes = [];
  List<Box> get boxes => _boxes;
  set boxes(List<Box> value) {
    _boxes = value;
    notifyListeners();
  }

  var _getting = false;
  bool get getting => _getting;
  set getting(bool value) {
    _getting = value;
    notifyListeners();
  }

  void getAllChips() async {
    // print('valid: ${(network as HttpClient).token}');
    if (_getting) return;
    if (!tokenValid) {
      boxes = [];
      return;
    }
    try {
      getting = true;
      final result = await network.reqRes(Api.boxGetAll(), init: Box.fromApi);
      final list = result.val.getLst<Box>();
      boxes = list ?? [];
    } catch (e) {
      // final err = e is HttpError ? e : HttpError.unknown;
      // onSnack?.call(err);
    } finally {
      getting = false;
    }
  }

  bool get tokenValid => network is HttpClient && (network as HttpClient).token?.isNotEmpty == true;
}
