import 'package:flutter/material.dart';
import '/pch.dart';

final class HomeVm extends ChangeNotifier {
  HomeVm({required this.network, required this.defaults});
  final Networkable network;
  final Defaults defaults;

  var _updating = false;
  DateTime? _userUpdatedTime;
  void updateUser() async {
    if (!tokenValid) return;
    if (timeValid(_userUpdatedTime, Duration(hours: 6))) return;
    if (_updating) return;
    try {
      _updating = true;
      final result = await network.reqRes(Api.accountGetUser(), init: User.fromApi);
      final user = result.val.getObj<User>();
      defaults.user = user;
      _userUpdatedTime = DateTime.now();
    } finally {
      _updating = false;
    }
  }

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
    try {
      getting = true;
      if (tokenValid) {
        final result = await network.reqRes(Api.boxGetAll(), init: Box.fromApi);
        boxes = result.val.getLst<Box>() ?? [];
      } else {
        boxes = [];
      }
    } catch (e) {
      // final err = e is HttpError ? e : HttpError.unknown;
      // onSnack?.call(err);
    } finally {
      getting = false;
    }
  }

  bool get tokenValid => network is HttpClient && (network as HttpClient).token?.isNotEmpty == true;
}
