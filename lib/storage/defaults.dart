import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '/core/core.dart';
import 'hive_ext.dart';
import '/models/user.dart';

enum _Keys { kThemeCodeKey, kLanguageCodeKey, kCurrentUserKey }

final class Defaults extends ChangeNotifier {
  late Box<Object> _box;

  Future<void> init() async {
    Hive.init(pathmk('hive'));
    _box = await Hive.openBox<Object>('defaults');
  }

  Future<void> load() async {
    // await _box.setValue(_Keys.kThemeCodeKey.name, null);
    // await _box.setValue(_Keys.kLanguageCodeKey.name, null);
    if (kDebugMode) debugPrint('Defaults: ${_box.toMap()}');

    final themeVal = _box.getString(_Keys.kThemeCodeKey.name);
    _theme = ThemeMode.values.firstWhere((e) => e.name == themeVal, orElse: () => ThemeMode.system);

    final languageVal = _box.getList(_Keys.kLanguageCodeKey.name)?.whereType<String>().toList() ?? [];
    _language = languageVal.isNotEmpty ? Locale(languageVal[0], languageVal.elementAtOrNull(1)) : null;

    try {
      _user = _box.getObject(_Keys.kCurrentUserKey.name, User.fromJson);
    } catch (e) {
      if (kDebugMode) debugPrint('Defaults: load `user` failed, $e');
    }
  }

  late ThemeMode _theme;
  ThemeMode get theme => _theme;
  set theme(ThemeMode value) {
    _theme = value;
    _box.setValue(_Keys.kThemeCodeKey.name, value.name);
    notifyListeners();
  }

  Locale? _language;
  Locale? get language => _language;
  set language(Locale? value) {
    _language = value;
    final list = value is Locale ? [value.languageCode, ?value.countryCode] : null;
    _box.setValue(_Keys.kLanguageCodeKey.name, list);
    notifyListeners();
  }

  User? _user;
  User? get user => _user;
  set user(User? value) {
    _user = value;
    _box.setValue(_Keys.kCurrentUserKey.name, value?.toJson());
    notifyListeners();
  }
}
