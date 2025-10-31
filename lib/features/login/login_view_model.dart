import 'dart:async';
import 'package:flutter/material.dart';
import '/core/core.dart';
import '/storage/storage.dart';
import '/network/network.dart';
import '/models/user.dart';
import '/utils/api.dart';

final class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required Networkable network, required Secures secures, required Defaults defaults})
    : _network = network,
      _secures = secures,
      _defaults = defaults;
  final Networkable _network;
  final Secures _secures;
  final Defaults _defaults;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  ValueNotifier<bool> loginedPub = ValueNotifier(false);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final codeController = TextEditingController();

  var emailShowClear = false;
  var emailValid = false;

  int countdown = 0;
  bool get sendEnabled => emailValid && countdown <= 0;

  var submitEnabled = false;

  void emailChanged(String value) {
    emailShowClear = value.isNotEmpty;
    emailValid = value.isNotEmpty;
    validate();
  }

  void codeChanged(String value) {
    validate();
  }

  void validate() {
    submitEnabled = emailController.text.isNotEmpty && codeController.text.isNotEmpty;
    notifyListeners();
  }

  void clearAction() {
    emailController.clear();
    emailChanged('');
  }

  var _sending = false;
  bool get sending => _sending;
  set sending(bool value) {
    _sending = value;
    notifyListeners();
  }

  void sendAction() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_sending) return;
    sendCode(emailController.text);
  }

  void sendCode(String email) async {
    try {
      sending = true;
      // await Future.delayed(Duration(seconds: 60));
      final result = await _network.reqRes(Api.accountSendCode(email), null);
      sending = false;

      switch (result) {
        case Ok():
          final res = result.value;
          if (res.success) {
            snackPub.value = LocaledStr(res.message);
            startCounting();
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

  Timer? timer;
  void startCounting() {
    countdown = 60;
    notifyListeners();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        // print('tick: $countdown next');
        countdown -= 1;
        notifyListeners();
      } else {
        // print('tick: $countdown cancel');
        timer.cancel();
      }
    });
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
    checkCode(emailController.text, codeController.text);
  }

  void checkCode(String email, String code) async {
    try {
      submiting = true;
      // await Future.delayed(Duration(seconds: 60));
      final result = await _network.reqRes(Api.accountCheckCode(email, code), User.fromApi);
      submiting = false;

      switch (result) {
        case Ok():
          final res = result.value;
          if (res.success) {
            snackPub.value = LocaledStr(res.message);
            final user = res.getObject<User>();
            _secures.lastUsername = user?.email;
            _secures.accessToken = user?.token;
            _defaults.user = user;
            loginedPub.value = true;
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
    emailController.dispose();
    codeController.dispose();
    timer?.cancel();
    snackPub.dispose();
    loginedPub.dispose();
    super.dispose();
  }
}
