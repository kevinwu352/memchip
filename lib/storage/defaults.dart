import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '/core/core.dart';
import '/models/user.dart';

enum _Keys { kThemeCodeKey, kLanguageCodeKey, kCurrentUserKey }

final class Defaults extends ChangeNotifier {
  Map<String, Object> raw = {};
  late String path;

  Future<void> load() async {
    try {
      path = pathmk('defaults.json');
      final file = File(path);
      final str = await file.readAsString();
      raw = withValue(
        jsonDecode(str),
        (v) => v is Map ? v.map((k, v) => MapEntry(k as String, v as Object)) : <String, Object>{},
      );
      // raw.setValue(_Keys.kThemeCodeKey.name, null);
      // raw.setValue(_Keys.kLanguageCodeKey.name, null);
      if (kDebugMode) debugPrint('Defaults: $raw');

      _theme = withValue(
        withValue(raw[_Keys.kThemeCodeKey.name], (v) => v is String ? v : null),
        (v) => ThemeMode.values.firstWhere((e) => e.name == v, orElse: () => ThemeMode.system),
      );

      _language = withValue(
        withValue(raw[_Keys.kLanguageCodeKey.name], (v) => v is List ? v.whereType<String>().toList() : <String>[]),
        (v) => v.isNotEmpty ? Locale(v[0], v.elementAtOrNull(1)) : null,
      );

      _user = withValue(
        withValue(raw[_Keys.kCurrentUserKey.name], (v) => v is Map ? v.map((k, v) => MapEntry(k.toString(), v)) : null),
        (v) => v != null ? User.fromJson(v) : null,
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Defaults: load failed, $e');
    }
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

  late ThemeMode _theme;
  ThemeMode get theme => _theme;
  set theme(ThemeMode value) {
    _theme = value;
    notifyListeners();
    raw.setValue(_Keys.kThemeCodeKey.name, value.name);
    _timer = Timer(Duration.zero, synchronize);
  }

  Locale? _language;
  Locale? get language => _language;
  set language(Locale? value) {
    _language = value;
    notifyListeners();
    final list = value is Locale ? [value.languageCode, ?value.countryCode] : null;
    raw.setValue(_Keys.kLanguageCodeKey.name, list);
    _timer = Timer(Duration.zero, synchronize);
  }

  User? _user;
  User? get user => _user;
  set user(User? value) {
    _user = value;
    notifyListeners();
    raw.setValue(_Keys.kCurrentUserKey.name, value?.toJson());
    _timer = Timer(Duration.zero, synchronize);
  }
}
