import 'package:flutter/material.dart';
import '/core/core.dart';
import '/network/network.dart';

final class RegisterVm extends ChangeNotifier {
  RegisterVm({required Networkable network}) : _network = network;
  final Networkable _network;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);
  ValueNotifier<bool> donePub = ValueNotifier(false);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    //
  }
}
