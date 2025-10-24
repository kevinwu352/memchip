import 'dart:async';
import 'package:flutter/material.dart';
import '/core/core.dart';
import '/network/network.dart';
import '/utils/api.dart';

final class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required Networkable network}) : _network = network;
  final Networkable _network;

  ValueNotifier<String?> snack = ValueNotifier(null);

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
    sendCode(emailController.text);
    startCounting();
  }

  void sendCode(String email) async {
    try {
      // await Future.delayed(Duration(seconds: 1));
      // snack.value = HttpError.networkError().toString();
      final res = await _network.reqRaw(Api.accountSendCode(email));
      switch (res) {
        case Ok():
          break;
        case Error():
          snack.value = res.error.toString();
      }
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknownError();
      snack.value = err.toString();
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
