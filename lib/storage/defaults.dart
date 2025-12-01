import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '/core/core.dart';
import '/models/user.dart';

enum _Keys { theme, language, user }

final class Defaults extends ChangeNotifier {
  Map<String, Object> raw = {};
  late String path;

  Future<void> init() async {
    try {
      path = pathmk('defaults.json');
      final file = File(path);
      final str = await file.readAsString();
      raw = withValue(
        jsonDecode(str),
        (v) => v is Map ? v.map((k, v) => MapEntry(k as String, v as Object)) : <String, Object>{},
      );
      // raw.setValue(_Keys.theme.name, null);
      // raw.setValue(_Keys.language.name, null);
      if (kDebugMode) debugPrint('Defaults: $raw');
    } catch (e) {
      raw = {};
      if (kDebugMode) debugPrint('Defaults: load failed, $e');
    }
    load();
  }

  void load() {
    try {
      _theme = withValue(
        withValue(raw[_Keys.theme.name], (v) => v is String ? v : null),
        (v) => ThemeMode.values.firstWhere((e) => e.name == v, orElse: () => ThemeMode.system),
      );
    } catch (e) {}

    try {
      _language = withValue(
        withValue(raw[_Keys.language.name], (v) => v is List ? v.whereType<String>().toList() : <String>[]),
        (v) => v.isNotEmpty ? Locale(v[0], v.elementAtOrNull(1)) : null,
      );
    } catch (e) {}

    try {
      _user = withValue(
        withValue(raw[_Keys.user.name], (v) => v is Map ? v.map((k, v) => MapEntry(k.toString(), v)) : null),
        (v) => v != null ? User.fromJson(v) : null,
      );
    } catch (e) {}
  }

  Future<void> synchronize() async {
    try {
      final file = File(path);
      final str = jsonEncode(raw);
      await file.writeAsString(str);
    } catch (e) {
      if (kDebugMode) debugPrint('Defaults: synchronize failed, $e');
    }
  }

  Timer? __timer;
  set _timer(Timer? value) {
    __timer?.cancel();
    __timer = value;
  }

  ThemeMode _theme = ThemeMode.system;
  ThemeMode get theme => _theme;
  set theme(ThemeMode value) {
    _theme = value;
    notifyListeners();
    raw.setValue(_Keys.theme.name, value.name);
    _timer = Timer(Duration.zero, synchronize);
  }

  Locale? _language;
  Locale? get language => _language;
  set language(Locale? value) {
    _language = value;
    notifyListeners();
    final list = value is Locale ? [value.languageCode, ?value.countryCode] : null;
    raw.setValue(_Keys.language.name, list);
    _timer = Timer(Duration.zero, synchronize);
  }

  User? _user;
  User? get user => _user;
  set user(User? value) {
    _user = value;
    notifyListeners();
    raw.setValue(_Keys.user.name, value?.toJson());
    _timer = Timer(Duration.zero, synchronize);
  }
}
