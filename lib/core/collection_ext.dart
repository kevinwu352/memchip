extension MapExt<K, V> on Map<K, V> {
  void setValue(K k, V? v) {
    if (v is V) {
      this[k] = v;
    } else {
      remove(k);
    }
  }

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
}
