import 'dart:async';
import 'package:flutter/material.dart';
import '/pch.dart';

final class LoginVm extends ChangeNotifier {
  LoginVm({required Networkable network, required Secures secures, required Defaults defaults})
    : _network = network,
      _secures = secures,
      _defaults = defaults {
    // accountController.text = 'test101';
    // codeController.text = '123456';
  }
  final Networkable _network;
  final Secures _secures;
  final Defaults _defaults;

  ValueNotifier<Localable?> snackPub = ValueNotifier(null);
  ValueNotifier<bool> donePub = ValueNotifier(false);

  var _method = Method.password;
  Method get method => _method;
  set method(Method value) {
    if (_method != value) {
      _method = value;
      notifyListeners();
      codeClear();
    }
  }

  final accountController = TextEditingController();
  bool get accountShowClear => accountController.text.isNotEmpty;
  void accountClear() {
    accountController.clear();
    notifyListeners();
  }

  final codeController = TextEditingController();
  bool get codeShowClear => codeController.text.isNotEmpty;
  void codeClear() {
    codeController.clear();
    notifyListeners();
  }

  bool get codeShouldMask => method == Method.password && !_codeShow;

  bool _codeShow = false;
  bool get codeShow => _codeShow;
  set codeShow(bool value) {
    _codeShow = value;
    notifyListeners();
  }

  bool get sendEnabled => accountController.text.isNotEmpty && sendSeconds <= 0;
  int sendSeconds = 0;

  bool get submitEnabled => accountController.text.isNotEmpty && codeController.text.isNotEmpty;

  var _sending = false;
  bool get sending => _sending;
  set sending(bool value) {
    _sending = value;
    notifyListeners();
  }

  void sendAction() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_sending) return;
    sendCode(accountController.text);
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
    sendSeconds = 60;
    notifyListeners();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (sendSeconds > 0) {
        // print('tick: $sendSeconds next');
        sendSeconds -= 1;
        notifyListeners();
      } else {
        // print('tick: $sendSeconds cancel');
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
    if (method == Method.password) {
      login(accountController.text, codeController.text);
    } else {
      check(accountController.text, codeController.text);
    }
  }

  void login(String account, String code) async {
    try {
      submiting = true;
      // await Future.delayed(Duration(seconds: 60));
      final result = await _network.reqRes(Api.accountLogin(account, code), User.fromApi);
      submiting = false;
      switch (result) {
        case Ok():
          final res = result.value;
          if (res.success) {
            snackPub.value = LocaledStr(res.message);
            final user = res.getObject<User>();
            _secures.lastUsername = user?.account;
            _secures.accessToken = user?.token;
            _defaults.user = user;
            donePub.value = true;
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

  void check(String account, String code) async {
    try {
      submiting = true;
      // await Future.delayed(Duration(seconds: 60));
      final result = await _network.reqRes(Api.accountCheckCode(account, code), User.fromApi);
      submiting = false;
      switch (result) {
        case Ok():
          final res = result.value;
          if (res.success) {
            snackPub.value = LocaledStr(res.message);
            final user = res.getObject<User>();
            _secures.lastUsername = user?.account;
            _secures.accessToken = user?.token;
            _defaults.user = user;
            donePub.value = true;
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
    accountController.dispose();
    codeController.dispose();
    timer?.cancel();
    snackPub.dispose();
    donePub.dispose();
    super.dispose();
  }
}

enum Method {
  password,
  otp;

  String name(BuildContext context) {
    switch (this) {
      case password:
        return AppLocalizations.of(context)!.login_method_password;
      case otp:
        return AppLocalizations.of(context)!.login_method_otp;
    }
  }

  String accountPh(BuildContext context) {
    switch (this) {
      case password:
        return AppLocalizations.of(context)!.login_account_ph1;
      case otp:
        return AppLocalizations.of(context)!.login_account_ph2;
    }
  }

  String passcodeTitle(BuildContext context) {
    switch (this) {
      case password:
        return AppLocalizations.of(context)!.login_password_title;
      case otp:
        return AppLocalizations.of(context)!.login_code_title;
    }
  }
}
