import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '/core/core.dart';
import '/models/user.dart';

enum _Keys { kThemeCodeKey, kLanguageCodeKey, kCurrentUserKey }

final class Defaults extends ChangeNotifier {
  late Box<Object> _box;

  Future<void> init() async {
    Hive.init(pathmk('hive'));
    _box = await Hive.openBox<Object>('defaults');
  }

  Future<void> load() async {
    try {
      // await _box.setValue(_Keys.kThemeCodeKey.name, null);
      // await _box.setValue(_Keys.kLanguageCodeKey.name, null);
      if (kDebugMode) debugPrint('Defaults: ${_box.toMap()}');

      _theme = withValue(
        withValue(_box.get(_Keys.kThemeCodeKey.name), (v) => v is String ? v : null),
        (v) => ThemeMode.values.firstWhere((e) => e.name == v, orElse: () => ThemeMode.system),
      );

      _language = withValue(
        withValue(
          _box.get(_Keys.kLanguageCodeKey.name),
          (v) => v is List ? v.whereType<String>().toList() : <String>[],
        ),
        (v) => v.isNotEmpty ? Locale(v[0], v.elementAtOrNull(1)) : null,
      );

      _user = withValue(
        withValue(
          _box.get(_Keys.kCurrentUserKey.name),
          (v) => v is Map ? v.map((k, v) => MapEntry(k.toString(), v)) : null,
        ),
        (v) => v != null ? User.fromJson(v) : null,
      );
    } catch (e) {
      if (kDebugMode) debugPrint('Defaults: load failed, $e');
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

extension HiveBoxExt<E> on Box<E> {
  Future<void> setValue(String key, E? value) async => value is E ? await put(key, value) : await delete(key);
}
