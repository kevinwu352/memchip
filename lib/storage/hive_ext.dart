import 'package:hive/hive.dart';
import '/core/core.dart';

extension HiveBoxExt<E> on Box<E> {
  Future<void> setValue(String? key, E? value) async {
    if (key is String) {
      if (value is E) {
        await put(key, value);
      } else {
        await delete(key);
      }
    }
  }

  E? getValue(String? key) => key is String ? get(key) : null;

  // ================================================================================

  bool? getBool(String? key) => getValue(key).asOr<bool>();
  int? getInt(String? key) => getValue(key).asOr<int>();
  double? getDouble(String? key) => getValue(key).asOr<double>();
  String? getString(String? key) => getValue(key).asOr<String>();

  List<Object?>? getList(String? key) => getValue(key).asOr<List>();

  // ================================================================================

  Map<String, Object?>? getMap(String? key) => getValue(key).asOr<Map>()?.map((k, v) => MapEntry(k.toString(), v));

  List<Map<String, Object?>?>? getMapList(String? key) => getList(key)
      ?.where((e) => e == null || e is Map)
      .map((e) => e is Map ? e.map((k, v) => MapEntry(k.toString(), v)) : null)
      .toList();

  // ================================================================================

  T? getObject<T>(String? key, T Function(Map<String, dynamic>) init) {
    final map = getMap(key);
    return map != null ? init(map) : null;
  }

  List<T?>? getObjectList<T>(String? key, T Function(Map<String, dynamic>) init) {
    return getMapList(key)?.map((e) => e != null ? init(e) : null).toList();
  }
}
