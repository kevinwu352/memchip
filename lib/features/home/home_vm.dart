import 'package:flutter/material.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/utils/api.dart';
import '/models/box.dart';

final class HomeVm extends ChangeNotifier {
  HomeVm({required Networkable network}) : _network = network;

  Networkable _network;
  void updateNetwork(Networkable net) {
    // Networkable old = _network;
    // if (old is HttpClient && net is HttpClient) {
    //   if (old.token != net.token) {
    //     _network = net;
    //     getAllChips();
    //   }
    // }
    _network = net;
    getAllChips();
  }

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  List<Box> _boxes = [];
  List<Box> get boxes => _boxes;
  set boxes(List<Box> value) {
    _boxes = value;
    notifyListeners();
  }

  void getAllChips() async {
    if (_network is! HttpClient || (_network as HttpClient).token?.isNotEmpty != true) {
      boxes = [];
      return;
    }
    try {
      // await Future.delayed(Duration(seconds: 60));
      final result = await _network.reqRes(Api.getAllChips(), Box.fromApi);
      switch (result) {
        case Ok():
          final res = result.value;
          if (res.success) {
            snackPub.value = LocaledStr(res.message);
            final list = res.getList<Box>();
            boxes = list ?? [];
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

  @override
  void dispose() {
    // snackPub.dispose();
    super.dispose();
  }
}
