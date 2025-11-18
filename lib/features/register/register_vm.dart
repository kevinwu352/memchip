import 'package:flutter/material.dart';
import '/pch.dart';

final class RegisterVm extends ChangeNotifier {
  RegisterVm({required this.network, this.onSnack, this.onRegistered}) {
    // accountController.text = 'ts00';
    // codeController.text = '123456';
    // confirmController.text = '123456';
  }
  final Networkable network;
  final void Function(dynamic msg)? onSnack;
  final void Function()? onRegistered;

  void cancel() {
    accountController.dispose();
    codeController.dispose();
    confirmController.dispose();
  }

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
    _register(accountController.text, codeController.text);
  }

  void _register(String account, String code) async {
    try {
      submiting = true;
      final result = await network.reqRes(Api.accountRegister(account, code));
      final res = result.val.checked;
      onSnack?.call(res.message);
      onRegistered?.call();
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    } finally {
      submiting = false;
    }
  }
}
