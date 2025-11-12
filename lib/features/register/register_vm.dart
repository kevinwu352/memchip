import 'package:flutter/material.dart';
import '/pch.dart';

final class RegisterVm extends ChangeNotifier {
  RegisterVm({required Networkable network, void Function(dynamic msg)? onSnack, void Function()? onComplete})
    : _network = network,
      _onSnack = onSnack,
      _onComplete = onComplete {
    // accountController.text = 'ts00';
    // codeController.text = '123456';
    // confirmController.text = '123456';
  }
  final Networkable _network;

  final void Function(dynamic msg)? _onSnack;
  final void Function()? _onComplete;

  final accountController = TextEditingController();
  bool get accountShowClear => accountController.text.isNotEmpty;
  void accountClear() {
    accountController.clear();
    notifyListeners();
  }

  final codeController = TextEditingController();

  bool _codeShow = false;
  bool get codeShow => _codeShow;
  set codeShow(bool value) {
    _codeShow = value;
    notifyListeners();
  }

  bool get submitEnabled =>
      accountController.text.isNotEmpty &&
      codeController.text.isNotEmpty &&
      confirmController.text == codeController.text;

  final confirmController = TextEditingController();
  bool _confirmShow = false;
  bool get confirmShow => _confirmShow;
  set confirmShow(bool value) {
    _confirmShow = value;
    notifyListeners();
  }

  var _submiting = false;
  bool get submiting => _submiting;
  set submiting(bool value) {
    _submiting = value;
    notifyListeners();
  }

  void submitAction() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_submiting) return;
    register(accountController.text, codeController.text);
  }

  void register(String account, String code) async {
    try {
      submiting = true;
      // await Future.delayed(Duration(seconds: 60));
      final result = await _network.reqRes(Api.accountRegister(account, code));
      submiting = false;
      switch (result) {
        case Ok():
          final res = result.value;
          if (res.success) {
            _onSnack?.call(LocaledStr(res.message));
            _onComplete?.call();
          } else {
            throw HttpError.operation;
          }
        case Error():
          throw result.error;
      }
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      _onSnack?.call(err);
    }
  }
}
