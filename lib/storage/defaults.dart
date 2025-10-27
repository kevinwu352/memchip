import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '/core/core.dart';
import '/models/user_model.dart';
import 'hive_ext.dart';

enum _DefaultsKeys { kThemeCodeKey, kLanguageCodeKey, kCurrentUserKey }

final class Defaults extends ChangeNotifier {
  late Box<Object> _box;

  Future<void> init() async {
    Hive.init(pathmk('hive'));
    _box = await Hive.openBox<Object>('defaults');
  }

  Future<void> load() async {
    // await _box.setValue(_DefaultsKeys.kThemeCodeKey.name, null);
    // await _box.setValue(_DefaultsKeys.kLanguageCodeKey.name, null);
    if (kDebugMode) debugPrint('${_box.toMap()}');

    final themeVal = _box.getString(_DefaultsKeys.kThemeCodeKey.name);
    _theme = ThemeMode.values.firstWhere((e) => e.name == themeVal, orElse: () => ThemeMode.system);

    final languageVal = _box.getList(_DefaultsKeys.kLanguageCodeKey.name)?.whereType<String>().toList() ?? [];
    _language = languageVal.isNotEmpty ? Locale(languageVal[0], languageVal.elementAtOrNull(1)) : null;

    final userVal = _box.getMap(_DefaultsKeys.kCurrentUserKey.name);
    _user = userVal != null ? UserModel.fromJson(userVal) : null;
  }

  late ThemeMode _theme;
  ThemeMode get theme => _theme;
  set theme(ThemeMode value) {
    _theme = value;
    _box.setValue(_DefaultsKeys.kThemeCodeKey.name, value.name);
    notifyListeners();
  }

  Locale? _language;
  Locale? get language => _language;
  set language(Locale? value) {
    _language = value;
    final list = value is Locale ? [value.languageCode, ?value.countryCode] : null;
    _box.setValue(_DefaultsKeys.kLanguageCodeKey.name, list);
    notifyListeners();
  }

  UserModel? _user;
  UserModel? get user => _user;
  set user(UserModel? value) {
    _user = value;
    _box.setValue(_DefaultsKeys.kCurrentUserKey.name, value?.toJson());
    notifyListeners();
  }
}
