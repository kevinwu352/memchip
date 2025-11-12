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
      // await Future.delayed(Duration(seconds: 60));
      final result = await network.reqRes(Api.boxGetAll(), Box.fromApi);
      switch (result) {
        case Ok():
          final res = result.value;
          if (res.success) {
            // onSnack?.call(res.message);
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
      // onSnack?.call(err);
    }
  }

  bool get tokenValid => network is HttpClient && (network as HttpClient).token?.isNotEmpty == true;
}
