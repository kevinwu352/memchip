import 'package:flutter/material.dart';
import '/pch.dart';

final class HomeVm extends ChangeNotifier {
  HomeVm({required Networkable network}) : _network = network;
  final Networkable _network;

  List<Box> _boxes = [];
  List<Box> get boxes => _boxes;
  set boxes(List<Box> value) {
    _boxes = value;
    notifyListeners();
  }

  void getAllChips() async {
    // print('valid: ${(_network as HttpClient).token}');
    if (!tokenValid) {
      boxes = [];
      return;
    }
    try {
      // await Future.delayed(Duration(seconds: 60));
      final result = await _network.reqRes(Api.boxGetAll(), Box.fromApi);
      switch (result) {
        case Ok():
          final res = result.value;
          if (res.success) {
            // _onSnack?.call(res.message);
            final list = res.getList<Box>();
            boxes = list ?? [];
          } else {
            throw HttpError.operation;
          }
        case Error():
          throw result.error;
      }
    } catch (e) {
      // final err = e is HttpError ? e : HttpError.unknown;
      // _onSnack?.call(err);
    }
  }

  bool get tokenValid => _network is HttpClient && _network.token?.isNotEmpty == true;
}
