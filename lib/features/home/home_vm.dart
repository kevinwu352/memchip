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

  void getAllChips() async {
    // print('valid: ${(network as HttpClient).token}');
    if (!tokenValid) {
      boxes = [];
      return;
    }
    try {
      final result = await network.reqRes(Api.boxGetAll(), init: Box.fromApi);
      final list = result.val.getLst<Box>();
      boxes = list ?? [];
    } catch (e) {
      // final err = e is HttpError ? e : HttpError.unknown;
      // onSnack?.call(err);
    }
  }

  bool get tokenValid => network is HttpClient && (network as HttpClient).token?.isNotEmpty == true;
}
