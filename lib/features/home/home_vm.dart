import 'package:flutter/material.dart';
import '/pch.dart';

final class HomeVm extends ChangeNotifier {
  HomeVm({required this.network, required this.defaults});
  final Networkable network;
  final Defaults defaults;

  var _updating = false;
  DateTime? _userUpdatedTime;
  void updateUser() async {
    if (timeValid(_userUpdatedTime, Duration(hours: 6))) return;
    if (_updating) return;
    try {
      _updating = true;
      if (tokenValid) {
        final result = await network.reqRes(Api.accountGetUser(), init: User.fromApi);
        final user = result.val.getObj<User>();
        defaults.user = user;
        _userUpdatedTime = DateTime.now();
      } else {
        //
      }
    } finally {
      _updating = false;
    }
  }

  var _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<Box> boxes = [];

  DateTime? _chipsUpdatedTime;
  void loadChips() async {
    if (timeValid(_chipsUpdatedTime, Duration(seconds: 30))) return;
    if (_loading) return;
    try {
      loading = true;
      if (tokenValid) {
        final result = await network.reqRes(Api.boxGetAll(), init: Box.fromApi);
        boxes = result.val.getLst<Box>() ?? [];
        _chipsUpdatedTime = DateTime.now();
      } else {
        boxes = [];
      }
    } finally {
      loading = false;
    }
  }

  bool get tokenValid => withValue(network, (v) => v is HttpClient && v.token?.isNotEmpty == true);
}
