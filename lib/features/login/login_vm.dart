import 'dart:async';
import 'package:flutter/material.dart';
import '/pch.dart';

final class LoginVm extends ChangeNotifier {
  LoginVm({required this.network, required this.secures, required this.defaults, this.onSnack, this.onComplete}) {
    // accountController.text = 'test101';
    // codeController.text = '123456';
  }
  final Networkable network;
  final Secures secures;
  final Defaults defaults;
  final void Function(dynamic msg)? onSnack;
  final void Function()? onComplete;

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
    _sendCode(accountController.text);
  }

  void _sendCode(String email) async {
    try {
      sending = true;
      final result = await network.reqRes(Api.accountSendCode(email));
      final res = result.val.checked;
      onSnack?.call(res.message);
      _startCounting();
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    } finally {
      sending = false;
    }
  }

  Timer? _timer;
  void _startCounting() {
    sendSeconds = 60;
    notifyListeners();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
      _login(accountController.text, codeController.text);
    } else {
      _check(accountController.text, codeController.text);
    }
  }

  void _login(String account, String code) async {
    try {
      submiting = true;
      final result = await network.reqRes(Api.accountLogin(account, code), init: User.fromApi);
      final res = result.val;
      final user = res.getObj<User>();
      onSnack?.call(res.message);
      secures.lastUsername = user?.account;
      secures.accessToken = user?.token;
      defaults.user = user;
      onComplete?.call();
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    } finally {
      submiting = false;
    }
  }

  void _check(String account, String code) async {
    try {
      submiting = true;
      final result = await network.reqRes(Api.accountCheckCode(account, code), init: User.fromApi);
      final res = result.val;
      final user = res.getObj<User>();
      onSnack?.call(res.message);
      secures.lastUsername = user?.account;
      secures.accessToken = user?.token;
      defaults.user = user;
      onComplete?.call();
    } catch (e) {
      final err = e is HttpError ? e : HttpError.unknown;
      onSnack?.call(err);
    } finally {
      submiting = false;
    }
  }

  @override
  void dispose() {
    accountController.dispose();
    codeController.dispose();
    _timer?.cancel();
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
