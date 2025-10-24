import 'dart:async';
import 'package:flutter/material.dart';
import '/network/network.dart';

final class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required Networkable network}) : _network = network;
  final Networkable _network;

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
    sendCode();
    startCounting();
  }

  void sendCode() {
    //     try {
    //       final network = context.read<Networkable>();
    //       final res = await network.reqRaw(Api.accountSendCode('wuhp@proton.me'));
    //       switch (res) {
    //         case Ok():
    //           print('done');
    //         case Error():
    //           print(res.error);
    //       }
    //     } catch (e) {
    //       final error = e is HttpError ? e : HttpError.unknownError();
    //       print(error);
    //     }
  }

  void startCounting() {
    countdown = 60;
    notifyListeners();

    Timer.periodic(Duration(seconds: 1), (timer) {
      // if (!mounted) {
      //   // print('tick: unmounted cancel');
      //   timer.cancel();
      //   return;
      // }
      if (countdown > 0) {
        print('tick: $countdown next');
        countdown -= 1;
        notifyListeners();
      } else {
        print('tick: $countdown cancel');
        timer.cancel();
      }
    });
  }

  void submitAction() {
    print('qwerty');
  }

  // @override
  void dis() {
    emailController.dispose();
    codeController.dispose();
    // super.dispose();
  }
}
