import 'object_ext.dart';

extension MapExt<K, V> on Map<K, V> {
  void setValue(K k, V? v) {
    if (v is V) {
      this[k] = v;
    } else {
      remove(k);
    }
  }

  // ================================================================================

  bool? getBool(K key) => this[key].asOr<bool>();
  int? getInt(K key) => this[key].asOr<int>();
  double? getDouble(K key) => this[key].asOr<double>();
  String? getString(K key) => this[key].asOr<String>();

  Map<String, Object?>? getMap(K key) => this[key].asOr<Map>()?.map((k, v) => MapEntry(k.toString(), v));

  List<Object?>? getList(K key) => this[key].asOr<List>();
  List<T>? getListOf<T>(K key) => this[key].asOr<List>()?.whereType<T>().toList();

  // ================================================================================

  Map<K, V> where(bool Function(K k, V v) test) => Map.fromEntries(entries.where((e) => test(e.key, e.value)));

  Map<K, T> whereType<T>() => Map.fromEntries(entries.where((e) => e.value is T)).cast<K, T>();

  Map<K, T> compactMap<T>(T? Function(K k, V v) transform) => Map.fromEntries(
    entries.map((e) => MapEntry(e.key, transform(e.key, e.value))).where((e) => e.value != null),
  ).cast<K, T>();
}

extension IterableExt<E> on Iterable<E> {
  Iterable<T> compactMap<T>(T? Function(E e) transform) => map((e) => transform(e)).whereType<T>();

  Map<E, T> toMap<T>(T? Function(E e) transform) =>
      Map.fromEntries(map((e) => MapEntry(e, transform(e))).where((e) => e.value != null)).cast<E, T>();

  E? firstWhereOrNull(bool Function(E e) test) {
    for (var e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}
