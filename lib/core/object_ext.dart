// final v = ...;
// return v != null ? init(v) : null;
//
// withValue(getMap(key), (v) => v != null ? init(v) : null);
T2 withValue<T1, T2>(T1 v, T2 Function(T1 v) h) => h(v);

// num? n = null;
//
// final aa = n.as<int>();
// print(aa);
//
// final bb = n.asOr<int>() ?? 13;
// print(bb);
extension ObjectAsExt on Object? {
  T as<T>() => this as T;

  T? asOr<T>() {
    var self = this;
    return self is T ? self : null;
  }
}
