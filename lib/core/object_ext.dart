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
