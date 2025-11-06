import 'package:flutter/material.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/utils/api.dart';

final class HomeVm extends ChangeNotifier {
  HomeVm({required Networkable network}) : _network = network;
  final Networkable _network;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  List<int> chips = [];

  void getAllChips() async {
    try {
      // await Future.delayed(Duration(seconds: 60));
      final result = await _network.reqRes(Api.getAllChips(), null);
      switch (result) {
        case Ok():
          final res = result.value;
          if (res.success) {
            snackPub.value = LocaledStr(res.message);
            // ...
          } else {
            throw HttpError.operation;
          }
        case Error():
          throw result.error;
      }
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      snackPub.value = err;
    }
  }
}
