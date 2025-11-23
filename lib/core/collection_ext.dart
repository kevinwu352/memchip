import 'uncat.dart';

extension IterableExt<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E e) test) {
    for (var e in this) {
      if (test(e)) return e;
    }
    return null;
  }

  E? lastWhereOrNull(bool Function(E e) test) {
    for (var e in this) {
      if (test(e)) return e;
    }
    return null;
  }

  Iterable<T> compactMap<T>(T? Function(E e) transform) => map((e) => transform(e)).whereType<T>();

  // ================================================================================

  Map<E, T> toMap<T>(T? Function(E e) transform) =>
      Map.fromEntries(map((e) => MapEntry(e, transform(e))).where((e) => e.value != null)).cast<E, T>();
}

extension MapExt<K, V> on Map<K, V> {
  Map<K, V> where(bool Function(K k, V v) test) => Map.fromEntries(entries.where((e) => test(e.key, e.value)));

  Map<K, T> whereType<T>() => Map.fromEntries(entries.where((e) => e.value is T)).cast<K, T>();

  Map<K, T> compactMap<T>(T? Function(K k, V v) transform) => Map.fromEntries(
    entries.map((e) => MapEntry(e.key, transform(e.key, e.value))).where((e) => e.value != null),
  ).cast<K, T>();

  // ================================================================================

  void setValue(K k, V? v) => v is V ? this[k] = v : remove(k);

  bool? getBool(K key) => withValue(this[key], (v) => v is bool ? v : null);
  int? getInt(K key) => withValue(this[key], (v) => v is int ? v : null);
  double? getDouble(K key) => withValue(this[key], (v) => v is double ? v : null);
  String? getString(K key) => withValue(this[key], (v) => v is String ? v : null);

  Map<String, Object?>? getMap(K key) =>
      withValue(this[key], (v) => v is Map ? v.map((k, v) => MapEntry(k.toString(), v as Object?)) : null);

  List<Object?>? getList(K key) => withValue(this[key], (v) => v is List ? v.whereType<Object?>().toList() : null);
  List<T>? getListOf<T>(K key) => withValue(this[key], (v) => v is List ? v.whereType<T>().toList() : null);
}
