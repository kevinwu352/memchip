import 'dart:async';
import 'package:flutter/material.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/utils/api.dart';

final class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required Networkable network}) : _network = network;
  final Networkable _network;

  ValueNotifier<Localizable?> snack = ValueNotifier(null);

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

  void sendAction() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_sending) return;
    sendCode(emailController.text);
  }

  var _sending = false;
  bool get sending => _sending;
  set sending(bool value) {
    _sending = value;
    notifyListeners();
  }

  void sendCode(String email) async {
    try {
      sending = true;
      final result = await _network.reqRes(Api.accountSendCode(email), null);
      sending = false;

      switch (result) {
        case Ok():
          final res = result.value;
          if (res.success) {
            snack.value = LocaleString(res.message);
            startCounting();
          } else {
            throw HttpError.operation;
          }
        case Error():
          throw result.error;
      }
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      snack.value = err;
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

  void submitAction() {
    FocusManager.instance.primaryFocus?.unfocus();
    print('qwerty');
  }

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    timer?.cancel();
    snack.dispose();
    super.dispose();
  }
}
